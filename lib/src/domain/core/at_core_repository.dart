

import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/login_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/paddock_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/registration_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/user_dto.dart';

abstract class ATCoreRepository {

  Future<void> register(RegistrationDto registration);

  Future<UserDto> login(LoginDto login);

  Future<FarmDTO> addFarm(FarmDTO farm);

  Future<List<FarmDTO>> getFarms(UserDto user);

  Future<List<PaddockDTO>> getPaddocks(FarmDTO farm);
}