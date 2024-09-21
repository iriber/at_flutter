
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/lockup.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class AnimalType extends GenericModel{

  Lookup? type;

  AnimalType(
      { int id=-1,this.type}):super(id);

  AnimalType.empty():super(-1);

  AnimalType.fromMap(Map<String, dynamic> item):super(item["id"]) {
    AnimalType.fromJson(item);
  }

  AnimalType.fromJson(dynamic item):super(item["id"]) {
    type= Lookup.fromJson(item["type"]);
  }

  Map<String, Object> toMap(){
    return {
      'iid':id,
      'type_code':type?.code??"",
    };
  }

  bool isNotEmpty() {
    return id>0;
  }
/*
  AnimalType.fromDto(AnimalTypeDTO dto):super(dto.id) {
    name =  dto.name;
    code =  dto.code;
  }*/

}