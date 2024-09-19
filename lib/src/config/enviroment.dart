import 'dart:io';

import 'package:agro_tracking_flutter/src/config/at_config.dart';
import 'package:agro_tracking_flutter/src/config/at_dev_config.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Environment {

  Environment._internal();

  static final Environment _singleton = Environment._internal();

  factory Environment() {
    return _singleton;
  }

  static const String DEV = 'DEV';
  static const String STAGING = 'STAGING';
  static const String PROD = 'PROD';
  final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  late ATConfig config;

  Future<void> initConfig(String environment) async{
    config = _getConfig(environment);
    await config.init();

    debugPrint("ENVIRONMENT: " + config.toString());

    config.appTheme = AppTheme(1);

  }

  ATConfig _getConfig(String environment) {
    switch (environment) {
      case Environment.DEV:
        return ATDevConfig();
      default:
        return ATDevConfig();
    }
  }

  bool isProd(){
    return (config!=null)?config.isProd():false;
  }


  String getCountryISOCode() {
    final WidgetsBinding? instance = WidgetsBinding.instance;
    if (instance != null) {
      final List<Locale> systemLocales = instance.window.locales;
      String? isoCountryCode = systemLocales.first.countryCode;
      if (isoCountryCode != null) {
        return isoCountryCode;
      } else {
        return "USD-default";
      }
    } else {
      return "USD-default";
    }
  }
}