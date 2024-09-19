import 'package:flutter/widgets.dart';

import 'generic_model.dart';

class Menu extends GenericModel{

  String code="";
  String label="";
  String icon="";
  bool visible=true;
  String link="";
  String args="";

  Menu(id,
      { this.code="",
        this.label="",
        this.args="",
        this.icon="",
        this.link="",
        this.visible=true}):super(id);

  Menu.empty():super(-1);

  Menu.fromMap(Map<String, dynamic> item):super(item["id"]) {
    visible=(item["visible"]==1);
    args=item["args"]??"";
    code=item["code"]??"";
    label=item["label"]??"";
    icon=item["icon"]??"";
    link=item["link"]??"";
  }

  Menu.fromJson(dynamic item):super(item["id"]) {
    visible=(item["visible"]);
    args=item["args"]??"";
    code=item["code"]??"";
    label=item["label"]??"";
    icon=item["icon"]??"";
    link=item["link"]??"";
  }

  Map<String, Object> toMap(){
    return {
      'id':id,
      'visible': this.visible?1:0,
      'code':this.code,
      'args':this.args,
      'label':this.label,
      'icon':this.icon,
      'link':this.link};
  }

  dynamic buildLinkArgs(BuildContext context){
    dynamic result= this.args;

    return result;
  }
}