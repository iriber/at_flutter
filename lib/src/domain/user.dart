
import 'package:agro_tracking_flutter/src/domain/core/user_dto.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';


class User extends GenericModel{

  String name="";
  String email="";
  String token="";

  User(
      { int id=-1,this.name="",
        this.email="",
        this.token=""}):super(id);

  User.empty():super(-1);

  User.fromMap(Map<String, dynamic> item):super(item["id"]) {
    User.fromJson(item);
  }

  User.fromJson(dynamic item):super(item["id"]) {
    name=item["name"]??"";
    email=item["email"]??"";
    token=item["token"]??"";
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'name':this.name,
      'email':this.email,
      'token':this.token};
  }

  User.fromDto(UserDto dto):super(dto.id) {
    name =  dto.name;
    email = dto.email;
    id = dto.id;
  }
}