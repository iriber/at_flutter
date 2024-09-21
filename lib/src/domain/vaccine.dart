
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/lockup.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class Vaccine extends GenericModel{

  Lookup? type;
  Lookup? lab;
  String? dose;
  String? administration;
  String? serial;
  DateTime? due;
  bool applied=false;
  DateTime? appliedDate;


  Vaccine(
      { int id=-1,this.type,
      this.lab,this.applied=false, this.dose, this.administration, this.serial,this.due, this.appliedDate
      }):super(id);

  Vaccine.empty():super(-1);

  Vaccine.fromMap(Map<String, dynamic> item):super(item["id"]) {
    Vaccine.fromJson(item);
  }

  Vaccine.fromJson(dynamic item):super(item["id"]) {
    type= Lookup.fromJson(item["type"]);
    lab= Lookup.fromJson(item["lab"]);
    dose=item["dose"]??"";
    administration=item["administration"]??"";
    serial=item["serial"]??"";
    due=item["due"];
    appliedDate=item["appliedDate"];
    due=item["due"];
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'type_code':type?.code??"",
      'lab_code':lab?.code??"",
      'dose':dose??"",
      'administration':administration??"",
      'due':due??"",
      'applied':applied??false,
      'appliedDate':appliedDate??"",
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