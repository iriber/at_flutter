import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

enum AtPercentageFieldLabelPosition { inside, left, top}
enum AtPercentageFieldProgressType { circular, linear}

class AtPercentageField extends StatefulWidget {

  String label;
  AtPercentageFieldLabelPosition labelPosition;
  bool hideText;
  Widget? prefixIcon;
  String? error;
  void Function(int)? onChange;
  int? value;
  bool enabled;
  TextInputType? inputType;
  TextStyle? labelStyle;
  TextStyle? inputStyle;
  int labelSize;

  AtPercentageFieldProgressType? progressType;
  Color progressLowColor= Colors.red;
  Color progressMediumColor= Colors.orange;
  Color progressHighColor= Colors.green;

  /* between 1 and 10 */
  TextAlign? labelAlign;


  AtPercentageField(
      {this.labelAlign,
        this.progressType,this.progressHighColor= Colors.green, this.progressLowColor=Colors.red, this.progressMediumColor= Colors.orange, this.labelSize = 4, this.labelStyle, this.inputStyle, this.labelPosition = AtPercentageFieldLabelPosition
          .inside,  this.inputType, this.onChange, this.value, required this.label, this.hideText = false, this.prefixIcon, this.error, this.enabled = true});


  @override
  State<AtPercentageField> createState() => _AtPercentageFieldState(this.value??0);
}


class _AtPercentageFieldState extends State<AtPercentageField> {

  int _value=50;

  _AtPercentageFieldState(this._value){
  }

  @override
  Widget build(BuildContext context) {

    Widget input;
    switch(widget.labelPosition){

      case AtPercentageFieldLabelPosition.inside:
        input = buildInput(context);
      case AtPercentageFieldLabelPosition.left:
        input = buildLabelLeft(context);
      case AtPercentageFieldLabelPosition.top:
        input = buildLabelTop(context);
    }
    return input;


  }

  Widget buildLabelTop(BuildContext context) {
    bool hasError = !(widget.error??"").isEmpty;
    TextStyle? style = widget.labelStyle?? ATFonts().inputLabel;
    if(hasError){
      style = ATFonts().inputLabelError;
    }
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: style, textAlign: widget.labelAlign,),
        SizedBox(height: 8,),
        buildInput(context)
      ],
    );
  }
  Widget buildLabelLeft(BuildContext context) {

    bool hasError = !(widget.error??"").isEmpty;
    TextStyle? style = widget.labelStyle?? ATFonts().inputLabel;
    if(hasError){
      style = ATFonts().inputLabelError;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child:
          Padding(padding: EdgeInsets.only(right:8), child:
          Text(widget.label, style: style,textAlign: widget.labelAlign,)),
            flex: widget.labelSize
        ),
        Expanded(child: buildInput(context, hideLabel:true), flex:(10-widget.labelSize))
      ],
    );
  }
/*
  Widget buildInput(BuildContext context, {bool hideLabel=false}) {
    AppTheme appTheme = Environment().config.appTheme;
    bool hasError = !(widget.error??"").isEmpty;

    return InputDecorator(
        decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            filled: true,
            fillColor: appTheme.getBodyBackgroundColor(),
            contentPadding: EdgeInsets.all(10),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: appTheme.getBodyForegroundColor(), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: appTheme.getBodyForegroundColor(),
                  width: 1.0),
            ),
            labelStyle: ATFonts().inputLabel,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(),
            prefix: new CircularPercentIndicator(
              radius: 45.0,
              lineWidth: 4.0,

              percent: (_value==0)?0:_value.toDouble()/100,
              center: new Text("${_value}%"),
              progressColor: Colors.red,
            ),
            labelText:  (hideLabel)?null: "  ${widget.label}",
            errorBorder:  OutlineInputBorder(
              borderSide: BorderSide(
                  color: appTheme.getBodyForegroundColor(),
                  width: 1.0),
            ),
            errorText: _value.toString(),
            errorStyle: ATFonts().inputText,
            //prefixText:  _value.toString(),

        ),
        //isEmpty: selectedValue == null,
        child: Slider(
            value: _value.toDouble(),
            onChanged: (value) {
              //developer.log('Slider Value : $value');
              setState(() {
                _value = value.toInt();
                widget.onChange!(_value);
              });
            },
            label: _value.toString(),

            min: 0.0,
            max: 100.0
        )
    );

  }*/
  Widget buildInput(BuildContext context, {bool hideLabel=false}) {
    AppTheme appTheme = Environment().config.appTheme;
    bool hasError = !(widget.error??"").isEmpty;

    return InputDecorator(
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          filled: true,
          fillColor: appTheme.getBodyBackgroundColor(),
          contentPadding: EdgeInsets.all(10),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appTheme.getBodyForegroundColor(), width: 2),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: appTheme.getBodyForegroundColor(),
                width: 1.0),
          ),
          labelStyle: ATFonts().inputLabel,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(),
          //prefix: ,
          labelText:  (hideLabel)?null: "  ${widget.label}",
          errorBorder: hasError?OutlineInputBorder(
            borderSide: BorderSide(
                color: appTheme.getErrorBackgroundColor(),
                width: 1.0),
          ):null,
          errorText: hasError?widget.error:null,
          errorStyle: ATFonts().inputErrorText

        ),
        //isEmpty: selectedValue == null,
        child: _buildProgress(context)


    );

  }

  Widget _buildProgress(BuildContext context){
    switch(widget.progressType){
      case AtPercentageFieldProgressType.circular:
        return _buildCircular(context);
      case AtPercentageFieldProgressType.linear:
        return _buildLinear(context);
      case null:
        return _buildLinear(context);
    }
  }

  Widget _buildCircular(BuildContext context){
    return new CircularPercentIndicator(
      radius: 45.0,
      lineWidth: 10.0,
      percent: (_value==0)?0:_value.toDouble()/100,
      center: new Text("${_value}%"),
      progressColor:  _getProgressColor(),
      footer: Slider(
          value: _value.toDouble(),
          onChanged: (value) {
            //developer.log('Slider Value : $value');
            setState(() {
              _value = value.toInt();
              widget.onChange!(_value);
            });
          },
          label: _value.toString(),

          min: 0.0,
          max: 100.0
      ),
    );
  }

  Color _getProgressColor() {

    return getColorFromPercentage(_value);
  }

  Color getColorFromPercentage(int percentage) {
    if (percentage < 0) percentage = 0;
    if (percentage > 100) percentage = 100;

    int green = 255;
    int red = (percentage *255 ) ; // De 0 a 255
    return Color.fromARGB(255, red, green, 0);

  }

  Widget _buildLinear(BuildContext context){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
          new LinearPercentIndicator(
              //width: double.infinity,
              //animation: true,
              lineHeight: 20.0,
              //animationDuration: 2000,
              percent: (_value==0)?0:_value.toDouble()/100,
              center: new Text("${_value}%"),
              linearStrokeCap: LinearStrokeCap.roundAll,
              progressColor:  _getProgressColor()
          )

        ,
         Slider(
                value: _value.toDouble(),
                onChanged: (value) {
                  //developer.log('Slider Value : $value');
                  setState(() {
                    _value = value.toInt();
                    widget.onChange!(_value);
                  });
                },
                label: _value.toString(),

                min: 0.0,
                max: 100.0
            )
        ,

      ],
    );

  }
}