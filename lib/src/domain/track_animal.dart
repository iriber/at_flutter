
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class TrackAnimal extends GenericModel{

  String name="";
  User? user;
  Farm? farm;
  String date="";
  String time="";

  TrackAnimal(id,
      { this.name="",
      this.user}):super(id);

  TrackAnimal.empty():super(-1);

  TrackAnimal.fromMap(Map<String, dynamic> item):super(item["id"]) {
    TrackAnimal.fromJson(item);
  }

  TrackAnimal.fromJson(dynamic item):super(item["id"]) {
    name=item["name"]??"";
    user = User.fromJson(item["user"]);
    farm = Farm.fromJson(item["farm"]);
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'name':this.name,
      'farm': this.farm?.toMap()??'',
      'user': this.user?.toMap()??'',
    };
  }

  bool isNotEmpty() {
    return id>0;
  }

  TrackAnimal.fromDto(FarmDTO dto):super(dto.id) {
    name =  dto.name;
  }

}