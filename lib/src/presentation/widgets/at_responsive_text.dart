import 'package:agro_tracking_flutter/src/utils/at_responsive_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ATResponsiveText extends StatelessWidget{

  TextStyle? style;
  TextAlign? textAlign;
  int? maxLines;
  String text;

  ATResponsiveText(this.text, {this.maxLines, this.textAlign, this.style});

  @override
  Widget build(BuildContext context) {

    double textScale = ATResponsiveUtils().getTextScale(context);

    return Text(
      this.text,
      style: style,
      textAlign: textAlign,
      maxLines: maxLines,
      textScaleFactor: textScale,
    );
  }



}