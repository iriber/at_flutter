import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:fiona_i18n/fiona_i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AtDialogUtils {

  late String errorMsg;

  Widget buildAlert(BuildContext context, {String? lblYes, String? lblNo, String? title, required String confirmationQuestion, Future<bool>  Function(BuildContext context)? doAction }) {
    return AlertDialog(
      title: Text(
        title??Fionai18n.message("dialog.alertConfirmation.title"),
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold),
      ),
      content: Text(
        confirmationQuestion,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: <Widget>[
        MaterialButton(
          color: Colors.red,
          textColor: Colors.white,
          child: Text(lblNo??Fionai18n.message("dialog.alertConfirmation.no")),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        MaterialButton(
          color: Colors.white,
          textColor: Colors.red,
          child: Text(lblYes??Fionai18n.message("dialog.alertConfirmation.yes")),
          onPressed: () async {
             if( await doAction!(context)){
               Navigator.of(context).pop();
             }

          },
        ),
      ],
    );
  }

  Future<bool?> showConfirmDialog(BuildContext context, {String? lblYes, String? lblNo, String? title, String? confirmationQuestion}) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title??Fionai18n.message("dialog.alertClose.title"),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold),
          ),
          content: Text(
            confirmationQuestion??Fionai18n.message("dialog.alertClose.msg"),
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: <Widget>[
            MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text(lblNo??Fionai18n.message("dialog.alertClose.no")),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            MaterialButton(
              color: Colors.white,
              textColor: Colors.red,
              child: Text(lblYes??Fionai18n.message("dialog.alertClose.yes")),
              onPressed: () async {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }
}