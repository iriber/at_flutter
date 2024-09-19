
import 'package:agro_tracking_flutter/src/utils/forms/form_item.dart';

class FormStringItem extends FormItem{

  String? value;

  FormStringItem({this.value, String errorMessage=""}):super(errorMessage: errorMessage);
  setValue(String? value){
    this.value = value;
  }
  String? getValue(){
    return value;
  }
  bool isEmpty(){
    return value==null || (value?.isEmpty??false);
  }

}
