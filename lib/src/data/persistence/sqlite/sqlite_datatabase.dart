import 'package:agro_tracking_flutter/src/data/persistence/sqlite/sqlite_batch.dart';
import 'package:fiona_persistence/src/data/persistence/fiona_persistence.dart';
import 'package:fiona_persistence/src/data/persistence/fiona_persistence_batch.dart';
import 'package:fiona_persistence/src/data/persistence/fiona_persistence_scheme.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteDatabase implements FionaPersistence{

  late Database database;

  FionaPersistenceScheme scheme;

  SQLiteDatabase(this.scheme);

  Future<void> init() async {

    FionaPersistenceScheme scheme = getScheme();

    database = await openDatabase(
      join(scheme.getPath(), scheme.getSchemeName()),
      onCreate: (database, version) async {
          scheme.create(SqliteBatch(database), version);
      },
      onUpgrade: (db, oldVersion, newVersion) async {

          scheme.upgrade(SqliteBatch(db), oldVersion, newVersion);
      },
      version: scheme.getSchemeVersion()
    );
  }

  @override
  Future<int> add(String entityName, Map<String, Object?> entity) async{
    await init();
    final id = await database.insert(
        entityName, entity,
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  @override
  Future<List<Map<String, Object?>>> findAll(String entityName, {String? where, List<Object?>? whereArgs, String? orderBy, int? limit, int? offset}) async{
    await init();
    final List<Map<String, Object?>> queryResult =
        await database.query(entityName, orderBy: orderBy, where: where, whereArgs: whereArgs, limit: limit, offset: offset);
    return queryResult;
  }

  @override
  Future<Map<String, Object?>> findBy(String entityName, {String? where, List<Object?>? whereArgs}) async{

    final List<Map<String, Object?>> queryResult = await findAll(entityName, where: where, whereArgs: whereArgs);

    if(queryResult.length==1)
      return queryResult.first;
    else{
      throw Exception("");
    }
  }

  @override
  Future<List<Map<String, Object?>>> query(String sql, {List<Object?>? arguments}) async{
    await init();
    final List<Map<String, Object?>> queryResult =
        await database.rawQuery(sql, arguments);
    return queryResult;
  }

  @override
  Future<int> removeAll(String entityName) async{
    await init();
    return database.delete(entityName);
  }

  @override
  Future<int> remove(String entityName, {String? where, List<Object?>? whereArgs})  async{
    await init();
    return database.delete(entityName, where: where, whereArgs: whereArgs);
  }

  @override
  Future<bool> update(String entityName, Map<String, Object?> entity, String idName, dynamic idValue) async{
    await init();
    await database.update( entityName, entity,  where: '$idName = ?', whereArgs: [idValue]);
    return true;
  }

  @override
  Future<FionaPersistenceBatch> getBatch() async{
    await init();
    return SqliteBatch(database);
  }

  @override
  FionaPersistenceScheme getScheme() {
    return this.scheme;
  }




}