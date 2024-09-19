
import 'package:agro_tracking_flutter/src/domain/core/farm_dto.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class Farm extends GenericModel{

  String name="";
  User? user;

  Farm(
      {int id=-1, this.name="",
      this.user}):super(id);

  Farm.empty():super(-1);

  Farm.fromMap(Map<String, dynamic> item):super(item["id"]) {
    Farm.fromJson(item);
  }

  Farm.fromJson(dynamic item):super(item["id"]) {
    name=item["name"]??"";
    user = User.fromJson(item["user"]);
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'name':this.name,
      'user': this.user?.toMap()??'',
    };
  }

  bool isNotEmpty() {
    return id>0;
  }

  Farm.fromDto(FarmDTO dto):super(dto.id) {
    name =  dto.name;
  }

}