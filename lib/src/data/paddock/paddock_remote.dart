
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/user_dto.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/paddock_repository.dart';
import 'package:agro_tracking_flutter/src/domain/services/at_core_service.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/farm_repository.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class PaddockRemote implements PaddockRepository{

  final FionaLogger logger = DependencyManager().get<FionaLogger>();
  final ATCoreService coreService = DependencyManager().get<ATCoreService>();



  @override
  Future<Paddock> add(Paddock entity) async{
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<List<Paddock>> getAll(Farm farm) async{

    List<Paddock> paddocks = List.empty(growable: true);

    FarmDTO farmDTO = FarmDTO(id: farm.id);

    await coreService.getPaddocks(farmDTO).then((dtos){

      dtos.forEach((dto) {
        Paddock paddock = Paddock.fromDto(dto);
        paddock.farmId= farm.id;
        paddocks.add(paddock);
      });

    }).catchError((error, stackTrace){
      logger.e("Paddocks Core Service ERROR: ${error.toString()}");
      logger.e("$stackTrace");
    });

    return paddocks;
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

  @override
  Future<void> sync(List<Paddock> paddocks) {
    // TODO: implement sync
    throw UnimplementedError();
  }

}