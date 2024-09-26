
import 'package:agro_tracking_flutter/src/utils/forms/form_item.dart';


class FormDoubleItem extends FormItem{

  double? value;

  FormDoubleItem({this.value, String errorMessage=""}):super(errorMessage: errorMessage);

  setValue(double? value){
    this.value = value;
  }
  double? getValue(){
    return value;
  }
  bool isEmpty(){
    return value==null;
  }

  parse(String strValue) {
    try{
      value = double.parse(strValue);
    }catch(error){

    }
  }

}
