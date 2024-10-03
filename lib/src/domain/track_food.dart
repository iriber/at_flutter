
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
  double? hectares;
  int? consumptionPerAnimal;
  String? leftover;
  String? resource;
  String? availability;
  String? availabilityDays;

  String? growUp;
  String? fattening;
  String? habituation;
  double? cornPercentage;
  double? siloPercentage;
  double? expellerPercentage;
  double? premixPercentage;

  TrackFood(
      { int id=-1, this.trackId, this.lotDesc, this.lotId, this.hectares}):super(id);

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

  void updateWith(TrackFood trackFood){
    hectares = trackFood.hectares;
    consumptionPerAnimal = trackFood.consumptionPerAnimal;
    resource = trackFood.resource;
    availability = trackFood.availability;
    leftover = trackFood.leftover;
    availabilityDays = trackFood.availabilityDays;

    growUp = trackFood.growUp;
    fattening = trackFood.fattening;
    habituation = trackFood.habituation;
    cornPercentage = trackFood.cornPercentage;
    siloPercentage = trackFood.siloPercentage;
    expellerPercentage = trackFood.expellerPercentage;
    premixPercentage = trackFood.premixPercentage;

  }

}