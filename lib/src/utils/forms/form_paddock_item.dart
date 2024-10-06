
import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/domain/lockup.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_item.dart';


class FormPaddockItem extends FormItem{

  Paddock? value;

  FormPaddockItem({this.value, String errorMessage=""}):super(errorMessage: errorMessage);

  setValue(Paddock? value){
    this.value = value;
  }
  Paddock? getValue(){
    return value;
  }
  bool isEmpty(){
    return value==null;
  }

  parse(int? id, String? desc){
    value = Paddock(id: id??0, name: desc??"");
  }
}
