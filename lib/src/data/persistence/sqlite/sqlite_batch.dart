import 'package:fiona_persistence/src/data/persistence/fiona_persistence_batch.dart';
import 'package:sqflite/sqflite.dart';

class SqliteBatch extends FionaPersistenceBatch{

  Batch batch;

  SqliteBatch(Database db): batch = db.batch();

  Future<void> execute(String query)async{
    this.batch.execute(query);
  }

  Future<void> commit()async{
    this.batch.commit();
  }

}