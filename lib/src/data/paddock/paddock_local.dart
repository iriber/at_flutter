
import 'package:agro_tracking_flutter/src/data/persistence/dao/farm_dao.dart';
import 'package:agro_tracking_flutter/src/data/persistence/dao/paddock_dao.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/farm_repository.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/paddock_repository.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class PaddockLocal implements PaddockRepository{

  final FionaLogger logger = DependencyManager().get<FionaLogger>();
  final PaddockDAO dao = DependencyManager().get<PaddockDAO>();

  @override
  Future<Paddock> add(Paddock entity) async{
    int id = await dao.add(entity);
    entity.id = id;
    return entity;
  }

  @override
  Future<List<Paddock>> getAll(Farm farm) async{
    return dao.findAll(where: "farmId = ? ", whereArgs: [farm.id]);
  }

  @override
  Future<bool> remove(Paddock entity) async{
    dao.delete(entity);
    return true;
  }

  @override
  Future<bool> update(Paddock entity) async{
    return dao.update(entity);
  }

  @override
  Future<void> sync(List<Paddock> paddocks) async{
    //TODO do sync HERE.
    paddocks.forEach((element) {
      dao.delete(element);
      dao.add(element);
    });
  }

}