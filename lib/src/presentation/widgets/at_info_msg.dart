import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';

class ATInfoMessage extends StatelessWidget {
  final String infoMsg;

  ATInfoMessage({required this.infoMsg});

  @override
  Widget build(BuildContext context) {
    if (infoMsg.isNotEmpty) {
      Future.delayed(Duration(seconds: 1 ), () {
        Environment().rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
        Environment().rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
        Environment().rootScaffoldMessengerKey.currentState?.showSnackBar(_buildSnackBar());
      });
    }
    return SizedBox.shrink();
  }

  SnackBar _buildSnackBar() {
    AppTheme appTheme = Environment().config.appTheme;
    String message = infoMsg == null ? "" : infoMsg;
    return SnackBar(
      content: Text(message, style: ATFonts().getInfoText()),
      backgroundColor: appTheme.getInfoBackgroundColor(),
      behavior: SnackBarBehavior.floating,
      elevation: 20,
    );
  }
  static cleanMessages(){
    Environment().rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    Environment().rootScaffoldMessengerKey.currentState?.removeCurrentSnackBar();
  }

}
