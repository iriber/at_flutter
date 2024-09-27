import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ATMessagesUtils {

  late String errorMsg;

  static errorMessage(String? errorMsg, {int seconds=2}) {

    if( errorMsg?.isNotEmpty??false){
      Environment().rootScaffoldMessengerKey.currentState?.showSnackBar(_buildSnackBar(errorMsg??"", seconds));
    }
  }


  static SnackBar _buildSnackBar(String errorMsg, int seconds){
    AppTheme appTheme = Environment().config.appTheme;
    return SnackBar(
      content: _buildMsg(errorMsg),
      backgroundColor:  appTheme.getErrorBackgroundColor(),
      behavior: SnackBarBehavior.floating,
      duration:  Duration(seconds: seconds ),
      elevation: 20,
      margin: const EdgeInsets.only(
          right: 20,
          left: 20,
          bottom: 250
      ),
    );
  }


  static Widget _buildMsg(String errorMsg){
    AppTheme appTheme = Environment().config.appTheme;
    return
      Container(
        color: appTheme.getErrorBackgroundColor(),
        padding: const EdgeInsets.fromLTRB(40,10,40,10),
        child: Text(errorMsg,
            textAlign: TextAlign.center,
            style: ATFonts().errorText),
      );
  }

  static cleanMessages(){
    Environment().rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    Environment().rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  }

}