
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/lot.dart';
import 'package:agro_tracking_flutter/src/domain/media.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class TrackFood extends GenericModel{

  int? trackId;

  int? lotId;
  String? lotDesc;
  double? hectareas;
  double? consumoPorAnimal;
  String? remanente;

  String? resource;
  String? availability;
  String? availabilityDays;

  //TODO corral


  TrackFood(id,
      { this.trackId, this.lotDesc, this.lotId}):super(id);

  TrackFood.empty():super(-1);

  TrackFood.fromMap(Map<String, dynamic> item):super(item["id"]) {
    TrackFood.fromJson(item);
  }

  TrackFood.fromJson(dynamic item):super(item["id"]) {

    trackId = item["trackId"];
    lotId = item["lotId"];
    lotDesc = item["lotDesc"];
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'trackId':trackId??"",
      'lotId':lotId??"",
    };
  }

  bool isNotEmpty() {
    return id>0;
  }


}