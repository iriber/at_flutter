import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:fiona_i18n/fiona_i18n.dart';
import 'package:intl/intl.dart';


class Initializer {

  Initializer._internal();

  static final Initializer _singleton = Initializer._internal();

  factory Initializer() {
    return _singleton;
  }

  Future<void> init() async {
    const String environment = String.fromEnvironment(
      'ENVIRONMENT',
      defaultValue: Environment.STAGING,
    );

    await Environment().initConfig(environment);

    await Fionai18n().initialize();
    String locale = Intl.getCurrentLocale();
    print("LOCALE: $locale");
    locale = locale.split("_")[0];
    print("LOCALE: $locale");

  }

}



