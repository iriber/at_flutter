
import 'package:agro_tracking_flutter/src/utils/forms/form_item.dart';


class FormIntItem extends FormItem{

  int? value;

  FormIntItem({this.value, String errorMessage=""}):super(errorMessage: errorMessage);

  setValue(int? value){
    this.value = value;
  }
  int? getValue(){
    return value;
  }
  bool isEmpty(){
    return value==null;
  }

  parse(String strValue) {
    try{
      value = int.parse(strValue);
    }catch(error){

    }
  }

}
