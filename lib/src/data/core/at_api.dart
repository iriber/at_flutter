import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/data/api_service.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/core/at_core_repository.dart';
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/login_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/paddock_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/registration_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/user_dto.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class ATApi  implements ATCoreRepository{

  FionaLogger logger = DependencyManager().get<FionaLogger>();
  final String api = Environment().config.atCoreApiHost;
  final String apiVersion = Environment().config.atCoreApiVersion;

  int loginIntents=0;

  Map<String,String> getApiHeaders(){
    return {
      "Accept": "application/json",
      "Api-Version": apiVersion,
      "User-Agent": Environment().config.userAgent
    };
  }

  Future<dynamic> get(url) async {
    return ApiService().get(url, headers: getApiHeaders() );
  }

  Future<List<dynamic>> getList(url) async {
    return ApiService().getList(url, headers: getApiHeaders() );
  }

  Future<dynamic> post(Uri url, Map data) async {
    return ApiService().post(url, data, headers: getApiHeaders() );
  }

  @override
  Future<void> register(RegistrationDto registration) async{

  }

  @override
  Future<UserDto> login(LoginDto login)async {
    UserDto user = UserDto();
    user.email = login.email;
    user.password =login.password;
    user.name = "Luis";
    user.id=1;
    return user;
  }

  @override
  Future<FarmDTO> addFarm(FarmDTO company)async{
    FarmDTO newCompany = FarmDTO(name: company.name);
    return newCompany;
  }

  @override
  Future<List<FarmDTO>> getFarms(UserDto user)async{
    List<FarmDTO> dtos = List<FarmDTO>.empty(growable: true);

    FarmDTO farmDTO = FarmDTO.empty();
    farmDTO.id=1;
    farmDTO.name="La Escondida";
    farmDTO.userId = user.id;
    dtos.add(farmDTO);

    farmDTO = FarmDTO.empty();
    farmDTO.id=2;
    farmDTO.name="Las Marías";
    farmDTO.userId = user.id;
    dtos.add(farmDTO);

    return dtos;
  }


  @override
  Future<List<PaddockDTO>> getPaddocks(FarmDTO farm)async{
    List<PaddockDTO> paddocks = List<PaddockDTO>.empty(growable: true);

    if( farm.id> 1){
      PaddockDTO paddockDTO = PaddockDTO.empty();
      paddockDTO.id=1;
      paddockDTO.name="Potrero 1A";
      paddockDTO.farmId = farm.id;
      paddocks.add(paddockDTO);

      paddockDTO = PaddockDTO.empty();
      paddockDTO.id=2;
      paddockDTO.name="Potrero 2A";
      paddockDTO.farmId = farm.id;
      paddocks.add(paddockDTO);

    }else{
      PaddockDTO paddockDTO = PaddockDTO.empty();
      paddockDTO.id=3;
      paddockDTO.name="Potrero 1B";
      paddockDTO.farmId = farm.id;
      paddocks.add(paddockDTO);

      paddockDTO = PaddockDTO.empty();
      paddockDTO.id=4;
      paddockDTO.name="Potrero 2B";
      paddockDTO.farmId = farm.id;
      paddocks.add(paddockDTO);

    }


    return paddocks;
  }



}