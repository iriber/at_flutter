
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/paddock_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/lot.dart';

class Paddock extends GenericModel{

  String name="";
  int? farmId;

  List<Lot>? lots;

  Paddock(
      {int id=-1, this.name="",this.lots,  this.farmId}):super(id);

  Paddock.empty():super(-1);

  Paddock.fromMap(Map<String, dynamic> item):super(item["id"]) {
    Paddock.fromJson(item);
  }

  Paddock.fromJson(dynamic item):super(item["id"]) {
    name=item["name"]??"";
    farmId = item["farmId"];
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'name':name,
      'farmId': farmId??'',
    };
  }

  bool isNotEmpty() {
    return id>0;
  }

  String toString(){
    return name;
  }
  Paddock.fromDto(PaddockDTO dto):super(dto.id) {
    name =  dto.name;
    farmId = dto.farmId;

    List<Lot> lots = List.empty(growable: true);
    dto.lots?.forEach( (lotDto){
      lots.add(Lot.fromDto(lotDto));
    });
    this.lots=lots;

  }
  @override
  bool operator ==(Object other) {
    // Check if other is a Paddock and if names are equal
    if (identical(this, other)) return true;
    return other is Paddock && name == other.name;
  }

  @override
  int get hashCode => name.hashCode;
}