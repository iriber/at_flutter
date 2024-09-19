import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ATErrorMessage extends StatelessWidget{

  final String errorMsg;

  ATErrorMessage({required this.errorMsg});

  @override
  Widget build(BuildContext context) {

    if( errorMsg.isNotEmpty){

      Future.delayed(Duration(seconds: 1 ), () {
        ATErrorMessage.cleanMessages();
        Environment().rootScaffoldMessengerKey.currentState?.showSnackBar(_buildSnackBar());
      });

    }

    return SizedBox.shrink();
  }


  SnackBar _buildSnackBar(){
    AppTheme appTheme = Environment().config.appTheme;
    return SnackBar(
      content: _buildMsg(),
      backgroundColor:  appTheme.getErrorBackgroundColor(),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2 ),
      elevation: 20,
      margin: EdgeInsets.only(
          right: 20,
          left: 20,
          bottom: 250//(MediaQuery.of(context).size.height/2)
      ),
    );
  }


  Widget _buildMsg(){
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