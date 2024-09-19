import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ATInputFieldDecoration{

  static InputDecoration inputTextField({required String label, bool? hasError, Widget? prefixIcon, Widget? suffixIcon}) {
    AppTheme appTheme = Environment().config.appTheme;

    return InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        //errorText: error,
        filled: true,
        fillColor: appTheme.getBodyBackgroundColor(),
        contentPadding: EdgeInsets.all(10),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appTheme.getBodyForegroundColor(), width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: (hasError??false)?appTheme.getErrorBackgroundColor():appTheme.getBodyForegroundColor(),
              width: 1.0),
        ),
        labelStyle: ATFonts().regularText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(),
        prefix: VerticalDivider(width: 10,),
        labelText: "$label",

      );
  }



}