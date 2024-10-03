import 'package:agro_tracking_flutter/src/domain/lot.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_item.dart';


class FormLotItem extends FormItem{

  Lot? value;

  FormLotItem({this.value, String errorMessage=""}):super(errorMessage: errorMessage);

  setValue(Lot? value){
    this.value = value;
  }
  Lot? getValue(){
    return value;
  }
  bool isEmpty(){
    return value==null;
  }

  parse(int? id, String? desc){
    value = Lot(id: id??0);
    value?.name = desc??"";
  }
}
