import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ATCheckbox extends StatefulWidget {
  final Function(bool) callback;
  final bool initialValue;
  final bool isDarkBackground;
  const ATCheckbox({Key? key, required this.callback, this.initialValue=false, this.isDarkBackground=false }) : super(key: key);

  @override
  _ATCheckboxState createState() => _ATCheckboxState(this.initialValue,this.isDarkBackground);
}

class _ATCheckboxState extends State<ATCheckbox> {
  bool _checkbox = true;
  bool _isDarkBackground = true;
  _ATCheckboxState(this._checkbox, this._isDarkBackground);

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Environment().config.appTheme;

    return Checkbox(
      value: _checkbox,
      checkColor: appTheme.getSecondaryBackgroundColor(),
      fillColor: _isDarkBackground ? MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {

          return Colors.white;
        }) : null,
      onChanged: (value) {
        widget.callback(value!);
        setState(() => _checkbox = !_checkbox);},
    );

  }
}