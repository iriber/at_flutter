
import 'package:agro_tracking_flutter/src/domain/core/user_dto.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/services/at_core_service.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/farm_repository.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class FarmRemote implements FarmRepository{

  final FionaLogger logger = DependencyManager().get<FionaLogger>();
  final ATCoreService coreService = DependencyManager().get<ATCoreService>();



  @override
  Future<Farm> add(Farm entity) async{
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<List<Farm>> getAll(User user) async{

    List<Farm> farms = List.empty(growable: true);

    UserDto userDto = UserDto(id: user.id);

    await coreService.getFarms(userDto).then((dtos){

      dtos.forEach((dto) {
        Farm farm = Farm.fromDto(dto);
        farm.user = user;
        farms.add(farm);
      });

    }).catchError((error, stackTrace){
      logger.e("Company Core Service ERROR: ${error.toString()}");
      logger.e("$stackTrace");
    });

    return farms;
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

  @override
  Future<void> sync(List<Farm> farms) {
    // TODO: implement sync
    throw UnimplementedError();
  }

}