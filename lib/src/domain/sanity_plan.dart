
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:agro_tracking_flutter/src/domain/vaccine.dart';

class SanityPlan extends GenericModel{

  int? trackAnimalId;
  List<Vaccine>? vaccines;


  SanityPlan(
      { int id=-1,this.trackAnimalId,
      this.vaccines}):super(id);

  SanityPlan.empty():super(-1);

  SanityPlan.fromMap(Map<String, dynamic> item):super(item["id"]) {
    SanityPlan.fromJson(item);
  }

  SanityPlan.fromJson(dynamic item):super(item["id"]) {
    trackAnimalId=item["trackAnimalId"];
    //vacines??
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'trackAnimalId':trackAnimalId??"",
    };
  }

  bool isNotEmpty() {
    return id>0;
  }

}