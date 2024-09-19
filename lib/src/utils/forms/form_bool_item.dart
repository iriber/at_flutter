
import 'package:agro_tracking_flutter/src/utils/forms/form_item.dart';

class FormBoolItem extends FormItem{

  bool? value;

  FormBoolItem({this.value, String errorMessage=""}):super(errorMessage: errorMessage);

  bool isEmpty(){
    return value==null;
  }
  setValue(bool value){
    this.value = value;
  }
  bool? getValue(){
    return value;
  }
  bool isChecked(){
    return value??false;
  }
}
