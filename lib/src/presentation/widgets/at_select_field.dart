import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:fiona_i18n/fiona_i18n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ATSelectField extends StatefulWidget {

  final String label;
  final TextStyle? labelStyle;
  ATSelectFieldController selectFieldController;
  final bool enableSearch;
  final bool fillAllItems;
  Widget? prefixIcon;
  String? error;

  ATSelectField(
      {required this.selectFieldController,this.error, this.label="", this.labelStyle, this.fillAllItems=false, this.enableSearch=true, this.prefixIcon})
  ;
  @override
  State<ATSelectField> createState() => _ATSelectFieldState(label: this.label, labelStyle: this.labelStyle);
}

abstract class ATSelectFieldController{

  String? textNotFound;
  dynamic? selected;

  Future<List> findItems(String text);

  String getItemLabel(item);

  Future<List> findAll() async{
    return findItems("");
  }

  void setTextNotFound(String text) {
    textNotFound = text;
    setSelected(null);
  }

  void setSelected( item ){
    selected = item;
  }

  dynamic? getSelected(){
    return selected;
  }
}

class _ATSelectFieldState extends State<ATSelectField> {

  final String label;
  List items= List.empty(growable: true);
  dynamic selectedValue;
  final TextStyle? labelStyle;
  TextEditingController? controller;
  _ATSelectFieldState(
  { required this.label,this.labelStyle}){


/*
    widget.selectFieldController.findItems("").then((results){

      setState(() {
        items = results;
      });
    });*/
  }

  void initState() {
    if(widget.fillAllItems && items.length==0){

      widget.selectFieldController.findAll().then((results){
        setState(() {
          items = results;
        });
      });

    }
  }

  @override
  Widget build(BuildContext context) {



    if(widget.enableSearch){
      return buildSearchEnabled(context);
    }else{
      return buildSearchDisabled(context);
    }
    /*
    if(widget.enableSearch && controller==null ){
      controller = TextEditingController();


      controller?.addListener((){
        //here you have the changes of your textfield
        String textToFind = controller?.text??"";
        print("textToFind: ${textToFind}");

        widget.selectFieldController.findItems(textToFind).then((results){
          if(results.isEmpty){
            widget.selectFieldController.setTextNotFound(textToFind);
          }
          setState(() {
            items = results;
          });
        });


      });
    }
    return DropdownMenu(
      width: double.infinity,
      //initialSelection: ColorLabel.green,
      controller: widget.enableSearch?controller:null,
      // requestFocusOnTap is enabled/disabled by platforms when it is null.
      // On mobile platforms, this is false by default. Setting this to true will
      // trigger focus request on the text field and virtual keyboard will appear
      // afterward. On desktop platforms however, this defaults to true.
      requestFocusOnTap: true,
      label:  Text(this.label),
      initialSelection: widget.selectFieldController.selected,
      onSelected: (dynamic? selected){
        if(selected==null){
          widget.selectFieldController.setTextNotFound(controller?.text??"");
        }else{
          widget.selectFieldController.setSelected(selected);
        }
      },
      dropdownMenuEntries: items
          .map<DropdownMenuEntry>(
              ( item) {
            return DropdownMenuEntry(
              value: item,
              label: widget.selectFieldController.getItemLabel(item),
              enabled: true,
            );
          }).toList(),
    );*/

  }

  Widget buildSearchDisabled(BuildContext context) {
/*
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
              color: (hasError)?appTheme.getErrorBackgroundColor():appTheme.getBodyForegroundColor(),
              width: 1.0),
        ),
        labelStyle: ATFonts().regularText,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: OutlineInputBorder(),
        prefix: VerticalDivider(width: 10,),
        labelText: "  $label",

      ),
* */
    AppTheme appTheme = Environment().config.appTheme;
    bool hasError = !(widget.error??"").isEmpty;

    return InputDecorator(
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon??widget.prefixIcon,
          //errorText: error,
          filled: true,
          fillColor: appTheme.getBodyBackgroundColor(),
          contentPadding: EdgeInsets.only(right: 0),
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
          errorBorder: hasError?OutlineInputBorder(
            borderSide: BorderSide(
                color: appTheme.getErrorBackgroundColor(),
                width: 1.0),
          ):null,
          errorText: hasError?widget.error:null,
          errorStyle: ATFonts().inputErrorText

        ),
        isEmpty: selectedValue == null,
      child: DropdownButtonHideUnderline(
        child:DropdownButton<dynamic>(
          style: ATFonts().inputText,
          //icon: widget.prefixIcon??widget.prefixIcon,
          value: widget.selectFieldController.selected,
          hint: Text( label ),
          items: items.map((dynamic option) {
            return DropdownMenuItem<dynamic>(
              value: option,
              child: Text(widget.selectFieldController.getItemLabel(option)),
            );
          }).toList(),
          onChanged: (dynamic? newValue) {
            if(newValue==null){
              widget.selectFieldController.setTextNotFound(controller?.text??"");
            }else{
              widget.selectFieldController.setSelected(newValue);
            }
            setState(() {
              selectedValue = newValue;
            });

          },
          isExpanded: true, // Para que ocupe todo el ancho
        )
      )


    );



  }

  Widget buildSearchEnabled(BuildContext context) {

    if(items.isEmpty && widget.selectFieldController.selected!=null){
      items.add(widget.selectFieldController.selected);
    }
    if(controller==null ){
      controller = TextEditingController();
      controller?.addListener((){
        //here you have the changes of your textfield
        String textToFind = controller?.text??"";
        print("textToFind: ${textToFind}");

        widget.selectFieldController.findItems(textToFind).then((results){
          if(results.isEmpty){
            widget.selectFieldController.setTextNotFound(textToFind);
          }
          setState(() {
            items = results;
          });
        });


      });
    }
    return DropdownMenu(
      width: double.infinity,
      //initialSelection: ColorLabel.green,
      controller: widget.enableSearch?controller:null,
      // requestFocusOnTap is enabled/disabled by platforms when it is null.
      // On mobile platforms, this is false by default. Setting this to true will
      // trigger focus request on the text field and virtual keyboard will appear
      // afterward. On desktop platforms however, this defaults to true.
      requestFocusOnTap: true,
      label:  Text(this.label),
      initialSelection: widget.selectFieldController.selected,
      onSelected: (dynamic? selected){
        if(selected==null){
          widget.selectFieldController.setTextNotFound(controller?.text??"");
        }else{
          widget.selectFieldController.setSelected(selected);
        }
      },
      dropdownMenuEntries: items
          .map<DropdownMenuEntry>(
              ( item) {
            return DropdownMenuEntry(
              value: item,
              label: widget.selectFieldController.getItemLabel(item),
              enabled: true,
            );
          }).toList(),
    );

  }
}