import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ATSelectField extends StatefulWidget {

  final String label;
  final TextStyle? labelStyle;
  ATSelectFieldController selectFieldController;

  ATSelectField(
      {required this.selectFieldController, this.label="", this.labelStyle})
  ;
  @override
  State<ATSelectField> createState() => _ATSelectFieldState(label: this.label, labelStyle: this.labelStyle);
}

abstract class ATSelectFieldController{

  String? textNotFound;
  dynamic? selected;

  Future<List> findItems(String text);

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


  @override
  Widget build(BuildContext context) {

    if(items.isEmpty && widget.selectFieldController.selected!=null){
      items.add(widget.selectFieldController.selected);
    }
    if(controller==null){
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
      controller: controller,
      // requestFocusOnTap is enabled/disabled by platforms when it is null.
      // On mobile platforms, this is false by default. Setting this to true will
      // trigger focus request on the text field and virtual keyboard will appear
      // afterward. On desktop platforms however, this defaults to true.
      requestFocusOnTap: true,
      enableSearch: true,
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
              label: item.toString(),
              enabled: true,
            );
          }).toList(),
    );

  }
}