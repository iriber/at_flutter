
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/lockup.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class Media extends GenericModel{

  Lookup? mediaType; //photo or video
  Lookup? trackType; //animal, food, water...
  int? trackId;

  // src, geolocation, datetime (from metadata?)
  
  
  Media(
      { int id=-1,this.mediaType, this.trackType, this.trackId}):super(id);

  Media.empty():super(-1);

  Media.fromMap(Map<String, dynamic> item):super(item["id"]) {
    Media.fromJson(item);
  }

  Media.fromJson(dynamic item):super(item["id"]) {
    mediaType= Lookup.fromJson(item["mediaType"]);
    trackType= Lookup.fromJson(item["trackType"]);
    trackId = item["trackId"];
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'mediaType_code':mediaType?.code??"",
      'trackType_code':trackType?.code??"",
      'trackId':trackId??"",
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