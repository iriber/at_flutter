
import 'package:agro_tracking_flutter/src/domain/core/lot_dto.dart';

class PaddockDTO{

  int id=0;
  String name="";
  int farmId=0;
  List<LotDto>? lots;

  PaddockDTO(
      { this.id=0,
        this.farmId=0,
        this.name="",
      this.lots});

  PaddockDTO.empty();

  PaddockDTO.fromMap(Map<String, dynamic> item) {
    PaddockDTO.fromJson(item);
  }

  PaddockDTO.fromJson(dynamic item) {
    id=item["id"]??0;
    name=item["name"]??"";
    farmId=item["farmId"]??0;
  }

  Map<String, Object> toMap(){
    return {
      'name':this.name,
      'id':this.id,
      'farmId': this.farmId,};
  }
}