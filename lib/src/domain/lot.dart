
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/core/paddock_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';

class Lot extends GenericModel{

  String name="";
  int? paddockId;

  Lot(
      {int id=-1, this.name="",  this.paddockId}):super(id);

  Lot.empty():super(-1);

  Lot.fromMap(Map<String, dynamic> item):super(item["id"]) {
    Lot.fromJson(item);
  }

  Lot.fromJson(dynamic item):super(item["id"]) {
    name=item["name"]??"";
    paddockId = item["paddockId"];
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'name':name,
      'paddockId': paddockId??'',
    };
  }

  bool isNotEmpty() {
    return id>0;
  }

  String toString(){
    return name;
  }

  @override
  bool operator ==(Object other) {
    // Check if other is a Lot and if names are equal
    if (identical(this, other)) return true;
    return other is Lot && name == other.name;
  }

  @override
  int get hashCode => name.hashCode;
}