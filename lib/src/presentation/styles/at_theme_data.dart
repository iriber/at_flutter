import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/material.dart';


import '../../domain/app_theme.dart';

class ATThemeData {

  late AppTheme _appTheme;

  ATFonts atFonts=ATFonts();

  ThemeData buildTheme(AppTheme appTheme){
    _appTheme = appTheme;
    return ThemeData(
        brightness: Brightness.light,
        primaryColor: appTheme.getPrimaryBackgroundColor(),
        fontFamily: atFonts.fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: appTheme.getPrimaryBackgroundColor(),
          foregroundColor: appTheme.getPrimaryForegroundColor()
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: appTheme.getPrimaryBackgroundColor(),
            selectedItemColor: appTheme.getSecondaryBackgroundColor(),
            selectedIconTheme: IconThemeData(color: appTheme.getSecondaryBackgroundColor(), size: 30),
            unselectedIconTheme: IconThemeData(color: appTheme.getPrimaryForegroundColor(), size: 30),
            unselectedItemColor: appTheme.getPrimaryForegroundColor(),
            //selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold)
        ),
        textTheme:  TextTheme(
            displayLarge: atFonts.headline1,
            displayMedium: atFonts.headline2,
            displaySmall: atFonts.headline6,
        )

    );

  }
}
