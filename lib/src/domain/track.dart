
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/media.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/domain/track_food.dart';
import 'package:agro_tracking_flutter/src/domain/track_water.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

enum TrackType { livestock, agriculture, empty }
enum TrackLivestockType { animal, food, water, empty }

class Track extends GenericModel{

  int? userId;
  int? farmId;
  DateTime datetime = DateTime.timestamp();
  List<TrackAnimal>? animalTracks;
  List<TrackFood>? foodTracks;
  List<TrackWater>? waterTracks;
  List<Media>? medias;


  Track(
      { int id=-1, int? localId, bool sync=false,
      this.userId,this.farmId}):super(id,localId: localId, isSyncrhonized: sync);

  Track.empty():super(-1);

  Track.fromMap(Map<String, dynamic> item):super(item["id"]) {
    Track.fromJson(item);
  }

  Track.fromJson(dynamic item):super(item["id"]) {
    userId = item["userId"];
    farmId = item["farmd"];
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'datetime':datetime??"",
      'farmId': farmId??'',
      'userId': userId??'',
    };
  }

  bool isNotEmpty() {
    return (localId??0)>0;
  }


}