import 'package:flutter/cupertino.dart';

class ATResponsiveUtils{

  double getTextScale(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double textScale=1;
    if(screenWidth<=320)
      textScale = 0.5;
    if(screenWidth<=390)
      textScale = 0.8;

    return textScale;
  }

  double getButtonHeightScale(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    double scale=1;
    if(screenWidth<=321){
      scale = 0.75;
    }else if(screenWidth<=390) {
      scale = 0.85;
    }

    return scale;
  }

}