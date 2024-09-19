
import 'package:flutter/material.dart';

class MenuSectionItem{

  Widget icon;
  Widget? icon2;
  String title;
  String link;
  dynamic args;
  String code;

  MenuSectionItem({required this.code, required this.icon, this.icon2, required this.title, required this.link, this.args});
}