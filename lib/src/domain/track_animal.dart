
import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/media.dart';
import 'package:agro_tracking_flutter/src/domain/sanity_plan.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class TrackAnimal extends GenericModel{

  AnimalType? type;
  int? quantity;
  double? minWeight;
  double? maxWeight;
  double? avgWeight;

  int? corporalCapacity1;
  int? corporalCapacity1_5;
  int? corporalCapacity2;
  int? corporalCapacity2_5;
  int? corporalCapacity3;
  int? corporalCapacity3_5;
  int? corporalCapacity4;
  int? corporalCapacity4_5;
  int? corporalCapacity5;

  SanityPlan? sanityPlan;

  int? trackId;


  TrackAnimal(
      {int id=-1, this.type, this.trackId,
      this.quantity}):super(id);

  TrackAnimal.empty():super(-1);

  TrackAnimal.fromMap(Map<String, dynamic> item):super(item["id"]) {
    TrackAnimal.fromJson(item);
  }

  TrackAnimal.fromJson(dynamic item):super(item["id"]) {
    //name=item["name"]??"";
    trackId = item["trackId"];
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'trackId':trackId??"",

    };
  }

  bool isNotEmpty() {
    return id>0;
  }

}