
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';

class Lookup extends GenericModel{

  String code="";
  String label="";
  String type="";

  Lookup(id,
      { this.code="", this.label="", this.type=""}):super(id);

  Lookup.empty():super(-1);

  Lookup.fromMap(Map<String, dynamic> item):super(item["id"]) {
    Lookup.fromJson(item);
  }

  Lookup.fromJson(dynamic item):super(item["id"]) {
    code=item["code"]??"";
    code=item["type"]??"";
    code=item["label"]??"";
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'code':this.code,
      'type':this.type,
      'label':this.label,
    };
  }

  bool isNotEmpty() {
    return id>0;
  }


}