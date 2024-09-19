
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/domain/track_food.dart';
import 'package:agro_tracking_flutter/src/domain/track_water.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class Track extends GenericModel{

  Paddock? paddock;
  User? user;
  Farm? farm;
  DateTime datetime = DateTime.timestamp();
  TrackAnimal? trackAnimal;
  TrackFood? trackFood;
  TrackWater? trackWater;



  Track(
      { int id=-1,this.paddock,
      this.user}):super(id);

  Track.empty():super(-1);

  Track.fromMap(Map<String, dynamic> item):super(item["id"]) {
    Track.fromJson(item);
  }

  Track.fromJson(dynamic item):super(item["id"]) {
    paddock = Paddock.fromJson(item["paddock"]);
    user = User.fromJson(item["user"]);
    farm = Farm.fromJson(item["farm"]);
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'datetime':datetime??"",
      'paddock': this.paddock?.toMap()??'',
      'farm': this.farm?.toMap()??'',
      'user': this.user?.toMap()??'',
    };
  }

  bool isNotEmpty() {
    return id>0;
  }



}