

import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_animal_type_item.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_double_item.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_int_item.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_object_item.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class TrackAnimalForm{

  FormAnimalTypeItem _animalType = FormAnimalTypeItem();
  FormIntItem _quantity = FormIntItem();
  FormDoubleItem _minWeight = FormDoubleItem();
  FormDoubleItem _maxWeight = FormDoubleItem();
  FormDoubleItem _avgWeight = FormDoubleItem();

  TrackAnimalForm();

  String? _error;

  FormAnimalTypeItem getAnimalType() => _animalType;
  FormIntItem getQuantity() => _quantity;
  FormDoubleItem getMinWeight() => _minWeight;
  FormDoubleItem getMaxWeight() => _maxWeight;
  FormDoubleItem getAvgWeight() => _avgWeight;
  String? getError() => _error;

  bool validate(){
    bool animalRequired =  _animalType.checkEmpty(msg:Fionai18n.message("animalType.required"));
    bool quantityRequired = this._quantity.checkEmpty(msg:Fionai18n.message("quantity.required"));
    if(animalRequired || quantityRequired ){
      _error = Fionai18n.message("fields.required");
    }
    //_error = Fionai18n.message("fields.required");
    return !animalRequired && !quantityRequired;
  }

  TrackAnimalForm.empty() {
    _quantity = FormIntItem();
    _animalType = FormAnimalTypeItem();
    _minWeight = FormDoubleItem();
    _maxWeight = FormDoubleItem();
    _avgWeight = FormDoubleItem();
  }

  TrackAnimalForm.fromTrackAnimal(TrackAnimal trackAnimal) {
    fill(trackAnimal);
  }

  AnimalType? getAnimalTypeValue(){
    return  (_animalType.getValue()!=null)?(_animalType.getValue() as AnimalType):null;
  }

  TrackAnimal buildTrackAnimal(){
    TrackAnimal track = TrackAnimal.empty();

    AnimalType? animalType = _animalType.getValue();
    track.typeId = animalType?.id;
    track.typeDesc = animalType?.type?.label;

    track.quantity = _quantity.getValue();
    track.avgWeight = _avgWeight.getValue();
    track.maxWeight = _maxWeight.getValue();
    track.minWeight = _minWeight.getValue();

    return track;
  }

  void fill(TrackAnimal trackAnimal){
    getAnimalType().parse(trackAnimal.typeId, trackAnimal.typeDesc);
    getQuantity().setValue(trackAnimal.quantity);
    getMinWeight().setValue(trackAnimal.minWeight);
    getMaxWeight().setValue(trackAnimal.maxWeight);
    getAvgWeight().setValue(trackAnimal.avgWeight);

  }
}
