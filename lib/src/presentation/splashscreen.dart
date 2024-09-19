import 'package:agro_tracking_flutter/src/at_app.dart';
import 'package:agro_tracking_flutter/src/presentation/login/login_page.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/menu_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen  extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: buildSplash(context),
    );
  }
  
  @override
  Widget buildSplash(BuildContext context) {
    return AnimatedSplashScreen(splash: 
        Column(
          children: [
            Center(
              child: LottieBuilder.asset("assets/animations/splash.json", repeat: true,)
            )
          ],
        )
        ,
        //duration: 3000,
        splashIconSize: 400,
        backgroundColor:  Color(int.parse("0xFF329322")),
        nextScreen:  const ATApp());
  }
}