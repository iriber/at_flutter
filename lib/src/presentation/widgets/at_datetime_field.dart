import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AtDatetimeField extends StatefulWidget {

  final String label;
  DateTime? initialDatetime;
  Function(DateTime? datetime) onChanged;
  bool hideText;
  Widget? prefixIcon;
  String? error;

  final TextStyle? labelStyle;

  AtDatetimeField(
      {this.hideText=false, this.error, this.label="", this.initialDatetime, required this.onChanged, this.labelStyle})
  ;
  @override
  State<AtDatetimeField> createState() => _AtDatetimeFieldState( this.initialDatetime );
}

class _AtDatetimeFieldState extends State<AtDatetimeField> {

  DateTime? selectedDateTime;

  _AtDatetimeFieldState(this.selectedDateTime);

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Environment().config.appTheme;
    bool hasError = !(widget.error??"").isEmpty;

    return DateTimeField(
          value: selectedDateTime,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            //errorText: error,
            filled: true,
            fillColor: appTheme.getBodyBackgroundColor(),
            contentPadding: EdgeInsets.all(10),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appTheme.getBodyForegroundColor(), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: (hasError)?appTheme.getErrorBackgroundColor():appTheme.getBodyForegroundColor(),
                  width: 1.0),
            ),
            labelStyle: ATFonts().regularText,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            prefix: VerticalDivider(width: 10,),
            labelText: "  ${widget.label}",

          ),
          mode: DateTimeFieldPickerMode.time,
          //pickerPlatform: widget.platform,
          onChanged: (DateTime? value) {
            widget.onChanged(value);
            setState(() {
              selectedDateTime = value;
            });
          });

  }
}