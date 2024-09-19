import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:flutter/material.dart';


class ATFonts{

  String? get _fontPoppins => "poppins";
  String? get _fontBeVietnamePro => "BeVietnamPro";

  String? get fontFamily => _fontBeVietnamePro;

  TextStyle? get appBarTitle => getAppBarTitle();

  TextStyle? getAppBarTitle({Color? color}) => TextStyle(
      fontFamily: fontFamily,
      color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      fontWeight: FontWeight.w600,
      fontSize: 18);

  TextStyle? get headline1 => TextStyle(
      fontFamily: fontFamily,
      color: Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 32);

  TextStyle? get headline2 => TextStyle(
      fontFamily: fontFamily,
      color: Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 28);

  TextStyle? get headline3 => TextStyle(
      fontFamily: fontFamily,
      color: Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 24);

  TextStyle? get headline4 => getHeadline4();

  TextStyle? getHeadline4({Color? color}) => TextStyle(
      fontFamily: fontFamily,
      color: color??Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 32);

  TextStyle? getHeadline5({Color? color}) => TextStyle(
      fontFamily: fontFamily,
      color: color??Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 18);

  TextStyle? get headline5 => getHeadline5();

  TextStyle? get headline6 => getHeadline6();

  TextStyle? getHeadline6({Color? color}) => TextStyle(
      fontFamily: fontFamily,
      color: color??Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 16);

  TextStyle? getRegularText({Color? color}) => TextStyle(
      fontFamily: fontFamily,
      color: color??Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 16);

  TextStyle? get regularText => getRegularText();

  TextStyle? getSmallText({Color? color}) => TextStyle(
      fontFamily: fontFamily,
      color: color??Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 12);

  TextStyle? get smallText => getSmallText();

  TextStyle? get bodyText2 => getBodyText2();

  TextStyle? getBodyText2({Color? color}) => TextStyle(
      fontFamily: fontFamily,
      color: color??Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 16);

  TextStyle? get menuSettingsItem => TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      color: Environment().config.appTheme.getSurfacesForeground2Color(),
      fontSize: 18);


  TextStyle? get menuSettingsTitle => TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w600,
      color: Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 20);

  TextStyle? get menuSettingsSubtitle => TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      color: Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 16);

  TextStyle? get inputText => TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      color: Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 18);


  TextStyle? getButtonText({Color? color, double? fontSize }) => TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.bold,
      color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      fontSize: fontSize??16);

  TextStyle? get buttonText => getButtonText();

  TextStyle? get buttonTextSecondaryColor => getButtonText(color: Environment().config.appTheme.getSecondaryBackgroundColor());

  TextStyle? get linkText => TextStyle(
      fontFamily: fontFamily,
      fontWeight: FontWeight.w400,
      decoration: TextDecoration.underline,
      color: Environment().config.appTheme.getBodyForegroundColor(),
      fontSize: 14);


  TextStyle? get loginLinkText => linkText;


  TextStyle? get loginTitle => TextStyle(
      fontFamily: fontFamily,
      color: Environment().config.appTheme.getPrimaryBackgroundColor(),
      fontWeight: FontWeight.w600,
      fontSize: 20);

  TextStyle? get loginText => TextStyle(
            fontFamily: fontFamily,
            color: Environment().config.appTheme.getBodyForegroundColor(),
            fontWeight: FontWeight.w400,
            fontSize: 14);

  TextStyle? get registerLinkText => linkText;

  TextStyle? get checkboxEventLabel => TextStyle(
      fontFamily: fontFamily,
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 14);

  TextStyle? get errorText => TextStyle(
          color: Environment().config.appTheme.getErrorForegroundColor(),
          fontWeight: FontWeight.w400,
          fontSize: 14);

  TextStyle? getInfoText({Color? color}) => TextStyle(
          color: color??Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 14);

  TextStyle? get registrationTitle => loginTitle;

  TextStyle? get confirmationCodeTitle => TextStyle(
      fontFamily: fontFamily,
      color: Environment().config.appTheme.getPrimaryBackgroundColor(),
      fontWeight: FontWeight.w600,
      fontSize: 16);


  /****************************************/
  /*********** Page headers  **************/
  /****************************************/

  TextStyle? get pageTitle => TextStyle(
          fontFamily: fontFamily,
          color: Environment().config.appTheme.getSecondaryBackgroundColor(),
          fontSize: 42);

  TextStyle? get myAccountTitle => pageTitle;

  TextStyle? get wifiTitle => pageTitle;


  TextStyle? getMenuSection(Color color) => TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontSize: 32);


  TextStyle? getMenuItem(Color color) => TextStyle(
          fontFamily: fontFamily,
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 16);

  TextStyle? getFunPassMenuItem(Color color) => TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 16);


  TextStyle? get myAccountUserInfoItem => TextStyle(
          color: Environment().config.appTheme.getBodyForegroundColor(),
          fontWeight: FontWeight.bold,
          fontSize: 18);

  TextStyle? get paymentError => getHeadline6(color: Colors.redAccent);

  TextStyle? get paymentSuccess => getHeadline5();

  TextStyle? get paymentInfoText => getHeadline6();

  TextStyle? get listItemTitle => TextStyle(
      color: Environment().config.appTheme.getBodyForegroundColor(),
      fontWeight: FontWeight.w600,
      fontSize: 18);

  TextStyle? get listItemSubtitle => TextStyle(
      color: Environment().config.appTheme.getBodyForegroundColor(),
      fontWeight: FontWeight.w600,
      fontSize: 14);

  TextStyle? get listItemRightText => TextStyle(
      color: Environment().config.appTheme.getBodyForegroundColor(),
      fontWeight: FontWeight.w600,
      fontSize: 16);

  TextStyle? get selectedTicketListDesc => TextStyle(
      color: Environment().config.appTheme.getSurfacesForegroundColor(),
      fontWeight: FontWeight.w600,
      fontSize: 22);

  TextStyle? get selectedTicketDesc => TextStyle(
      color: Environment().config.appTheme.getPrimaryForegroundColor(),
      fontWeight: FontWeight.w600,
      fontSize: 18);

  TextStyle? get ticketDesc => TextStyle(
      color: Environment().config.appTheme.getSurfacesForeground2Color(),
      fontWeight: FontWeight.w600,
      fontSize: 18);

  TextStyle? get ticketPriceFooter => TextStyle(
      color: Environment().config.appTheme.getPrimaryForegroundColor(),
      fontWeight: FontWeight.w600,
      fontSize: 54);

  TextStyle? get ticketPriceFooterNote => TextStyle(
      color: Environment().config.appTheme.getPrimaryForegroundColor(),
      fontWeight: FontWeight.w400,
      fontSize: 12);
}