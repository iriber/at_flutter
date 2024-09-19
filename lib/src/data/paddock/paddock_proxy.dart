
import 'package:agro_tracking_flutter/src/data/proxies/data_proxy.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/farm_repository.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/paddock_repository.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class PaddockProxy extends DataProxy<Paddock> implements PaddockRepository{

  final FionaLogger logger = DependencyManager().get<FionaLogger>();

  PaddockRepository localRepo = DependencyManager().get<PaddockRepository>(instanceName: DataProxy.local);
  PaddockRepository remoteRepo = DependencyManager().get<PaddockRepository>(instanceName: DataProxy.remote);

  @override
  Future<Paddock> add(Paddock entity) async{
    return localRepo.add(entity);
  }

  @override
  Future<List<Paddock>> getAll(Farm farm) async{
    return getDataBy(farm, remoteRepo.getAll, localRepo.getAll, synchLocalPaddocks);
  }

  @override
  Future<bool> remove(Paddock entity) async{
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<bool> update(Paddock entity) async{
    // TODO: implement update
    throw UnimplementedError();
  }

  Future<void> synchLocalPaddocks(List<Paddock> remotes) async{
    localRepo.sync(remotes);
  }

  @override
  Future<void> sync(List<Paddock> paddocks) {
    // TODO: implement sync
    throw UnimplementedError();
  }

}