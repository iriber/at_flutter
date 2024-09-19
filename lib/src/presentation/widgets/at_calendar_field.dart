import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ATCalendarField extends StatefulWidget {

  final String label;
  List<DateTime?>? initialDates;
  Function(List<DateTime?> dates) onChanged;
  String? error;

  final TextStyle? labelStyle;

  ATCalendarField(
      { this.label="", this.initialDates,this.error,  required this.onChanged, this.labelStyle})
  ;
  @override
  State<ATCalendarField> createState() => _ATCalendarFieldState();
}

class _ATCalendarFieldState extends State<ATCalendarField> {

  _ATCalendarFieldState();

  @override
  Widget build(BuildContext context) {
    AppTheme appTheme = Environment().config.appTheme;
    return Container(
      // margin: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 60),
       decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: appTheme.getBodyForegroundColor(), width: 1),
            ),
        child: CalendarDatePicker2(
          config: CalendarDatePicker2Config(
              dayTextStyle: ATFonts().regularText,
            controlsTextStyle:  ATFonts().regularText,
           selectedDayTextStyle:  ATFonts().regularText,
            selectedDayHighlightColor: Colors.green
          ),
          value: widget.initialDates??[],
          onValueChanged: (List<DateTime?> dates) {
            widget.onChanged(dates);

          },
        ));

  }
}