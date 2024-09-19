import 'dart:async';
import 'dart:io';

import 'package:agro_tracking_flutter/src/at_app.dart';
import 'package:agro_tracking_flutter/src/initializer.dart';
import 'package:agro_tracking_flutter/src/presentation/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';
import 'package:get_it/get_it.dart';


Future<void> main() async {

  runZonedGuarded(() async {

    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    HttpOverrides.global = MyHttpOverrides();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    FlutterError.onError = (FlutterErrorDetails details) async {
      FlutterError.dumpErrorToConsole(details);
      runApp(ErrorWidgetClass(details));
    };

    runApp( SplashScreen());
    FlutterNativeSplash.remove();
    await Initializer().init();


  },
        (error, stackTrace) async {
      print('Unexpected Future Error!');
      print('$error');
      print('$stackTrace');
    },
  );
}

class ErrorWidgetClass extends StatelessWidget{
  final FlutterErrorDetails errorDetails;
  ErrorWidgetClass(this.errorDetails);

  @override
  Widget build(BuildContext context) {
    return Text( errorDetails.exceptionAsString());
  }

}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

