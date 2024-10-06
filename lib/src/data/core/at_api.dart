import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/data/api_service.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/core/at_core_repository.dart';
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/login_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/lot_dto.dart';
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

    List<LotDto>? lots;

    if( farm.id> 1){

      lots = List<LotDto>.empty(growable: true);
      lots.add(LotDto(id: 1, name: "Lote 1A01"));
      lots.add(LotDto(id: 2, name: "Lote 1A02"));
      lots.add(LotDto(id: 3, name: "Lote 1A03"));
      PaddockDTO paddockDTO = PaddockDTO(id: 1, name: "Potrero 1A", farmId: farm.id, lots: lots);
      paddocks.add(paddockDTO);

      lots = List<LotDto>.empty(growable: true);
      lots.add(LotDto(id: 4, name: "Lote 2A01"));
      lots.add(LotDto(id: 5, name: "Lote 2A02"));
      lots.add(LotDto(id: 6, name: "Lote 2A03"));
      paddocks.add( PaddockDTO(id: 2, name: "Potrero 2A", farmId: farm.id, lots: lots));

    }else{

      lots = List<LotDto>.empty(growable: true);
      lots.add(LotDto(id: 7, name: "Lote 1B01"));
      lots.add(LotDto(id: 8, name: "Lote 1B02"));
      lots.add(LotDto(id: 9, name: "Lote 1B03"));
      paddocks.add( PaddockDTO(id: 3, name: "Potrero 1B", farmId: farm.id, lots: lots));

      lots = List<LotDto>.empty(growable: true);
      lots.add(LotDto(id: 10, name: "Lote 2B01"));
      lots.add(LotDto(id: 11, name: "Lote 2B02"));
      lots.add(LotDto(id: 12, name: "Lote 2B03"));
      paddocks.add( PaddockDTO(id: 4, name: "Potrero 2B", farmId: farm.id, lots: lots));

    }


    return paddocks;
  }



}