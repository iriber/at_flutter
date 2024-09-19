import 'package:agro_tracking_flutter/src/domain/core/at_core_repository.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/login_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/paddock_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/registration_dto.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';
import 'package:agro_tracking_flutter/src/domain/core/user_dto.dart';

class ATCoreService {

  ATCoreRepository coreRepository = DependencyManager().get<ATCoreRepository>();

  FionaLogger logger = DependencyManager().get<FionaLogger>();

  Future<void> register(RegistrationDto registration) async{
    coreRepository.register(registration);
  }

  Future<UserDto> login(LoginDto login)async{
    return coreRepository.login(login);
  }

  Future<List<FarmDTO>> getFarms(UserDto user)async{
    return coreRepository.getFarms(user);
  }

  Future<List<PaddockDTO>> getPaddocks(FarmDTO farm)async{
    return coreRepository.getPaddocks(farm);
  }
}