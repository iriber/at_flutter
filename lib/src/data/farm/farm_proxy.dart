
import 'package:agro_tracking_flutter/src/data/proxies/data_proxy.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/farm_repository.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class FarmProxy extends DataProxy<Farm> implements FarmRepository{

  final FionaLogger logger = DependencyManager().get<FionaLogger>();

  FarmRepository localRepo = DependencyManager().get<FarmRepository>(instanceName: DataProxy.local);
  FarmRepository remoteRepo = DependencyManager().get<FarmRepository>(instanceName: DataProxy.remote);

  @override
  Future<Farm> add(Farm entity) async{
    return localRepo.add(entity);
  }

  @override
  Future<List<Farm>> getAll(User user) async{
    return getDataBy(user, remoteRepo.getAll, localRepo.getAll, synchLocalFarms);
  }

  @override
  Future<bool> remove(Farm entity) async{
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Farm entity) async{
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<void> synchLocalFarms(List<Farm> remotes) async{
    localRepo.sync(remotes);
  }

  @override
  Future<void> sync(List<Farm> farms) {
    // TODO: implement sync
    throw UnimplementedError();
  }

}