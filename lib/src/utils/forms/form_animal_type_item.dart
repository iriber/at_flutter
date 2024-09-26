
import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/domain/lockup.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_item.dart';


class FormAnimalTypeItem extends FormItem{

  AnimalType? value;

  FormAnimalTypeItem({this.value, String errorMessage=""}):super(errorMessage: errorMessage);

  setValue(AnimalType? value){
    this.value = value;
  }
  AnimalType? getValue(){
    return value;
  }
  bool isEmpty(){
    return value==null;
  }

  parse(int? id, String? desc){
    value = AnimalType(id: id??0);
    value?.type = Lookup(0, label: desc??"");

  }
}
