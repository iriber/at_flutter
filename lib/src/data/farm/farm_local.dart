
import 'package:agro_tracking_flutter/src/data/persistence/dao/farm_dao.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/farm_repository.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class FarmLocal implements FarmRepository{

  final FionaLogger logger = DependencyManager().get<FionaLogger>();
  final FarmDAO dao = DependencyManager().get<FarmDAO>();

  @override
  Future<Farm> add(Farm entity) async{
    int id = await dao.add(entity);
    entity.id = id;
    return entity;
  }

  @override
  Future<List<Farm>> getAll(User user) async{
    return dao.findAll(where: "userId = ? ", whereArgs: [user.id]);
  }

  @override
  Future<bool> remove(Farm entity) async{
    dao.delete(entity);
    return true;
  }

  @override
  Future<bool> update(Farm entity) async{
    return dao.update(entity);
  }

  @override
  Future<void> sync(List<Farm> farms) async{
    //TODO do sync HERE.
    farms.forEach((element) {
      dao.delete(element);
      dao.add(element);
    });
  }

}