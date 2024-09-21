
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/lockup.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class TrackWater extends GenericModel{

  Lookup? type;
  Lookup? quality;
  Lookup? cleaning;
  Lookup? windmillQuality;
  Lookup? windmillQuantity;
  int? trackId;

  TrackWater(id,
      { this.type,this.quality,this.cleaning,
        this.windmillQuality, this.windmillQuantity, this.trackId
      }):super(id);

  TrackWater.empty():super(-1);

  TrackWater.fromMap(Map<String, dynamic> item):super(item["id"]) {
    TrackWater.fromJson(item);
  }

  TrackWater.fromJson(dynamic item):super(item["id"]) {
    type = Lookup.fromJson(item["type"]);
    quality = Lookup.fromJson(item["quality"]);
    cleaning = Lookup.fromJson(item["cleaning"]);
    windmillQuantity = Lookup.fromJson(item["windmillQuantity"]);
    windmillQuality = Lookup.fromJson(item["windmillQuality"]);
    trackId = item["trackId"];

  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'type_code':type?.code??"",
      'quality_code': this.quality?.code??"",
      'cleaning_code': this.cleaning?.code??"",
      'windmillQuality_code': this.windmillQuality?.code??"",
      'windmillQuantity_code': this.windmillQuantity?.code??"",
      'trackId':trackId??"",
    };
  }

  bool isNotEmpty() {
    return id>0;
  }

}