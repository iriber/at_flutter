import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ATTextField extends StatelessWidget{

  TextEditingController? controller;
  String label;
  bool hideText;
  Widget? prefixIcon;
  String? error;
  String? initialValue;
  void Function(String)? onChange;
  bool enabled;
  TextInputType? inputType;
  List<TextInputFormatter>? inputFormatters;

  ATTextField({this.inputFormatters, this.inputType, this.onChange,this.controller, required this.label, this.hideText=false, this.prefixIcon, this.error, this.initialValue, this.enabled=true});

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Environment().config.appTheme;
    bool hasError = !(error??"").isEmpty;

    return TextFormField(
      style: ATFonts().inputText,
      obscureText: hideText,
      keyboardType: inputType,
      inputFormatters: inputFormatters,
      enabled: this.enabled,
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
        prefixIcon: prefixIcon??prefixIcon,
        //errorText: error,
        filled: true,
        fillColor: appTheme.getBodyBackgroundColor(),
        contentPadding: EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appTheme.getBodyForegroundColor(), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: (hasError)?appTheme.getErrorBackgroundColor():appTheme.getBodyForegroundColor(),
              width: 1.0),
        ),
        labelStyle: ATFonts().regularText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(),
        prefix: VerticalDivider(width: 10,),
        labelText: "  $label",

      ),
    );
  }



}