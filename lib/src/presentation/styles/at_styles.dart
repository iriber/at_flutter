import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/material.dart';


class ATColors {
  static const Color whiteDefault = Color.fromARGB(255, 255, 255, 255);
}


class ATSideMenuStyles {

  static const TextStyle headerMenuSection = TextStyle(fontFamily: 'Roboto', fontSize: 20.0, fontWeight: FontWeight.w600, color: ATColors.whiteDefault);

  static TextStyle textMenuItem = getTextMenuItem();
  static TextStyle getTextMenuItem({Color? color}) =>
      TextStyle(
          fontSize: 16.0,
          fontFamily: ATFonts().fontFamily,
          fontWeight: FontWeight.w500,
          color: color??Environment().config.appTheme.getBodyForegroundColor()
      );

  static Color menuIconColor =  Environment().config.appTheme.getBodyForegroundColor();
}

class ATButtonStyles {


  static ButtonStyle getPrimaryBtn({TextStyle? textStyle, double? fontSize}) => ElevatedButton.styleFrom(
    backgroundColor: Environment().config.appTheme.getPrimaryBackgroundColor(),
    textStyle: textStyle??ATFonts().getButtonText(fontSize: fontSize),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );

  static ButtonStyle primaryBtn = getPrimaryBtn();

  static ButtonStyle secondaryBtn = ElevatedButton.styleFrom(
    backgroundColor: Environment().config.appTheme.getPrimaryForegroundColor(),
      textStyle: ATFonts().getButtonText(color: Environment().config.appTheme.getPrimaryBackgroundColor()),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
      ),
  );

  static ButtonStyle getTertiaryBtn({double? fontSize}) => ElevatedButton.styleFrom(
    backgroundColor:Environment().config.appTheme.getSurfacesBackgroundColor(),
    side: BorderSide(width: 3.0, color: Environment().config.appTheme.getSecondaryBackgroundColor()),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    textStyle:  ATFonts().getButtonText(fontSize: fontSize),
  );

  static ButtonStyle tertiaryBtn = getTertiaryBtn();

  static ButtonStyle getSecondaryBtnBordered({double? fontSize}) => ElevatedButton.styleFrom(
    backgroundColor: Environment().config.appTheme.getSecondaryBackgroundColor(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      side: BorderSide(width: 3.0, color:  Environment().config.appTheme.getPrimaryBackgroundColor()),
    ),
    textStyle: ATFonts().getButtonText(fontSize: fontSize, color: Environment().config.appTheme.getSecondaryForegroundColor()),
  );

  static ButtonStyle secondaryBtnBordered = getSecondaryBtnBordered();

  static ButtonStyle primaryBtnBordered = ElevatedButton.styleFrom(
    backgroundColor: Environment().config.appTheme.getBodyBackgroundColor(),
    side: BorderSide(width: 3.0, color:  Environment().config.appTheme.getSecondaryBackgroundColor()),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
    textStyle: ATFonts().buttonText,

  );

  static ButtonStyle primaryBtnBorderedOrange = ElevatedButton.styleFrom(
    backgroundColor: Environment().config.appTheme.getSecondaryBackgroundColor(),
    textStyle: ATFonts().buttonText,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
    ),
  );
}
