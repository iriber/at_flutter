import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum ATTextFieldLabelPosition { inside, left, top}

class ATTextField extends StatelessWidget{

  TextEditingController? controller;
  String label;
  ATTextFieldLabelPosition labelPosition;
  bool hideText;
  Widget? prefixIcon;
  String? error;
  String? initialValue;
  void Function(String)? onChange;
  bool enabled;
  TextInputType? inputType;
  TextAlign? inputTextAlign;
  TextStyle? labelStyle;
  TextStyle? inputStyle;
  int labelSize; /* between 1 and 10 */

  List<TextInputFormatter>? inputFormatters;

  ATTextField({this.labelSize=4,this.labelStyle, this.inputStyle, this.labelPosition=ATTextFieldLabelPosition.inside,this.inputTextAlign,this.inputFormatters, this.inputType, this.onChange,this.controller, required this.label, this.hideText=false, this.prefixIcon, this.error, this.initialValue, this.enabled=true});

  @override
  Widget build(BuildContext context) {

    Widget widget;
    switch(labelPosition){

      case ATTextFieldLabelPosition.inside:
        widget = buildInput(context);
      case ATTextFieldLabelPosition.left:
        widget = buildLabelLeft(context);
      case ATTextFieldLabelPosition.top:
        widget = buildLabelTop(context);
    }
    return widget;


  }

  Widget buildLabelTop(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle?? ATFonts().inputLabel,),
        SizedBox(height: 8,),
        buildInput(context)
      ],
    );
  }
  Widget buildLabelLeft(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: Text(label, style: labelStyle?? ATFonts().inputLabel,), flex: labelSize)
        ,
        Expanded(child: buildInput(context), flex:(10-labelSize))
      ],
    );
  }

  Widget buildInput(BuildContext context) {
    AppTheme appTheme = Environment().config.appTheme;
    bool hasError = !(error??"").isEmpty;

    return TextFormField(

      textAlign: inputTextAlign??TextAlign.start,
      style: inputStyle?? ATFonts().inputText,
      obscureText: hideText,
      keyboardType: inputType,
      inputFormatters: inputFormatters,
      enabled: this.enabled,
      controller: controller,
      initialValue: initialValue,
      decoration: InputDecoration(
          prefixIcon: prefixIcon??prefixIcon,
          //errorText: error,
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
          labelStyle: ATFonts().regularText,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: OutlineInputBorder(),
          prefix: VerticalDivider(width: 10,),
          labelText: "  $label",
          errorBorder: hasError?OutlineInputBorder(
            borderSide: BorderSide(
                color: appTheme.getErrorBackgroundColor(),
                width: 1.0),
          ):null,
          errorText: hasError?error:null,
          errorStyle: ATFonts().inputErrorText

      ),
    );
  }

}