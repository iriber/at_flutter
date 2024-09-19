
import 'package:agro_tracking_flutter/src/utils/forms/form_item.dart';


class FormObjectItem extends FormItem{

  Object? value;

  FormObjectItem({this.value, String errorMessage=""}):super(errorMessage: errorMessage);

  setValue(Object? value){
    this.value = value;
  }
  Object? getValue(){
    return value;
  }
  bool isEmpty(){
    return value==null;
  }


}
