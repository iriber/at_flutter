
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class Customer extends GenericModel{

  String name="";
  String email="";
  String cuit="";
  User? user;

  Customer(id,
      { this.name="",
        this.email="",
        this.cuit=""}):super(id);

  Customer.empty():super(-1);

  Customer.fromMap(Map<String, dynamic> item):super(item["id"]) {
    Customer.fromJson(item);
    User.fromJson(item["user"]);
  }

  Customer.fromJson(dynamic item):super(item["id"]) {
    name=item["name"]??"";
    email=item["email"]??"";
    cuit=item["cuit"]??"";
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'name':this.name,
      'email':this.email,
      'cuit':this.cuit,
      'user': this.user?.toMap()??''};
  }
}