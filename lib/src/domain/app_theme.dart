import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'generic_model.dart';

class AppTheme extends GenericModel{

  //AppTheme DEFAULT VALUES
  String primaryBackground="0xFF329322";
  String loginBackground="0xFFd7f0ef";
  String primaryForeground="0xFFffffff";
  String primaryForegroundAlt="0xFF0076a9";
  String secondaryBackground="0xFF74B526";
  String secondaryForeground="0xFFffffff";
  String tertiaryBackground="0xFFDFDFDF";
  String tertiaryForeground="0xFF000000";
  String bodyBackground="0xFFffffff";
  String bodyForeground="0xFF000000";
  String bodyForeground2="0xFF777777";
  String surfacesBackground="0xFF8497B0";
  String surfacesForeground="0xFFffffff";
  String surfacesForeground2="0xFF777777";
  String surfacesAltBackground="0xFF0076a9";
  String surfacesAltForeground="0xFFffffff";
  String errorBackground="0xFFc30c30";
  String successBackground="0x00ff00";
  String errorForeground="0xFFffffff";
  String infoForeground="0xFFffffff";
  String infoBackground="0xFF0076a9";

  //this is a fixed background color.
  String greyBackground="0xFF777777";
  String grey2Background="0xFF444444";

  AppTheme(id):super(id);

  AppTheme.fromMap(Map<String, dynamic> item):super(item["id"]) {

    primaryBackground=item["primaryBackground"];
    primaryForeground=item["primaryForeground"];
    primaryForegroundAlt=item["primaryForegroundAlt"];
    secondaryBackground=item["secondaryBackground"];
    secondaryForeground=item["secondaryForeground"];
    tertiaryBackground=item["tertiaryBackground"];
    tertiaryForeground=item["tertiaryForeground"];
    bodyBackground=item["bodyBackground"];
    bodyForeground=item["bodyForeground"];
    bodyForeground2=item["bodyForeground2"];
    surfacesBackground=item["surfacesBackground"];
    surfacesForeground=item["surfacesForeground"];
    surfacesForeground2=item["surfacesForeground2"];
    surfacesAltBackground=item["surfacesAltBackground"];
    surfacesAltForeground=item["surfacesAltForeground"];
    errorBackground=item["errorBackground"];
    errorForeground=item["errorForeground"];
  }

  AppTheme.fromJson( dynamic item):super(item["id"]) {
    primaryBackground=item["primaryBackground"];
    primaryForeground=item["primaryForeground"];
    primaryForegroundAlt=item["primaryForegroundAlt"];
    secondaryBackground=item["secondaryBackground"];
    secondaryForeground=item["secondaryForeground"];
    tertiaryBackground=item["tertiaryBackground"];
    tertiaryForeground=item["tertiaryForeground"];
    bodyBackground=item["bodyBackground"];
    bodyForeground=item["bodyForeground"];
    bodyForeground2=item["bodyForeground2"];
    surfacesBackground=item["surfacesBackground"];
    surfacesForeground=item["surfacesForeground"];
    surfacesForeground2=item["surfacesForeground2"];
    surfacesAltBackground=item["surfacesAltBackground"];
    surfacesAltForeground=item["surfacesAltForeground"];
    errorBackground=item["errorBackground"];
    errorForeground=item["errorForeground"];
  }

  Map<String, Object> toMap(){
    return {'id':id,
      'primaryBackground': primaryBackground,
      'primaryForeground': primaryForeground,
      'primaryForegroundAlt': primaryForegroundAlt,
      'secondaryBackground': secondaryBackground,
      'secondaryForeground': secondaryForeground,
      'tertiaryBackground': tertiaryBackground,
      'tertiaryForeground': tertiaryForeground,
      'bodyBackground': bodyBackground,
      'bodyForeground': bodyForeground,
      'bodyForeground2': bodyForeground2,
      'surfacesBackground': surfacesBackground,
      'surfacesForeground': surfacesForeground,
      'surfacesForeground2': surfacesForeground2,
      'surfacesAltBackground': surfacesAltBackground,
      'surfacesAltForeground': surfacesAltForeground,
      'errorBackground': errorBackground,
      'errorForeground': errorForeground
    };
  }

  AppTheme.empty():super(-1);

  Color getLoginBackgroundColor(){
    return Color(int.parse(loginBackground));
  }

  Color getPrimaryBackgroundColor(){
    return Color(int.parse(primaryBackground));
  }
  Color getPrimaryForegroundColor(){
    return Color(int.parse(primaryForeground));
  }
  Color getPrimaryForegroundAltColor(){
    return Color(int.parse(primaryForegroundAlt));
  }
  Color getSecondaryBackgroundColor(){
    return Color(int.parse(secondaryBackground));
  }
  Color getSecondaryForegroundColor(){
    return Color(int.parse(secondaryForeground));
  }
  Color getTertiaryBackgroundColor(){
    return Color(int.parse(tertiaryBackground));
  }
  Color getTertiaryForegroundColor(){
    return Color(int.parse(tertiaryForeground));
  }
  Color getBodyBackgroundColor(){
    return Color(int.parse(bodyBackground));
  }
  Color getBodyForegroundColor(){
    return Color(int.parse(bodyForeground));
  }
  Color getBodyForeground2Color(){
    return Color(int.parse(bodyForeground2));
  }
  Color getSurfacesBackgroundColor(){
    return Color(int.parse(surfacesBackground));
  }
  Color getSurfacesForegroundColor(){
    return Color(int.parse(surfacesForeground));
  }
  Color getSurfacesForeground2Color(){
    return Color(int.parse(surfacesForeground2));
  }
  Color getSurfacesAltBackgroundColor(){
    return Color(int.parse(surfacesAltBackground));
  }
  Color getSurfacesAltForegroundColor(){
    return Color(int.parse(surfacesAltForeground));
  }
  Color getErrorBackgroundColor(){
    return Color(int.parse(errorBackground));
  }
  Color getSuccessBackgroundColor(){
    return Color(int.parse(successBackground));
  }
  Color getErrorForegroundColor(){
    return Color(int.parse(errorForeground));
  }
  Color getInfoForegroundColor(){
    return Color(int.parse(errorForeground));
  }
  Color getInfoBackgroundColor(){
    return Color(int.parse(surfacesAltBackground));
  }

  Color getGreyBackgroundColor(){
    return Color(int.parse(greyBackground));
  }
  Color getGrey2BackgroundColor(){
    return Color(int.parse(grey2Background));
  }

}