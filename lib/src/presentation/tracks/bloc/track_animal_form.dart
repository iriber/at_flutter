

import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_object_item.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class TrackAnimalForm{

  FormObjectItem _animalType = FormObjectItem();
  FormObjectItem _quantity = FormObjectItem();
  FormObjectItem _minWeight = FormObjectItem();
  FormObjectItem _maxWeight = FormObjectItem();
  FormObjectItem _avgWeight = FormObjectItem();

  TrackAnimalForm();

  String? _error;

  FormObjectItem getAnimalType() => _animalType;
  FormObjectItem getQuantity() => _quantity;
  FormObjectItem getMinWeight() => _minWeight;
  FormObjectItem getMaxWeight() => _maxWeight;
  FormObjectItem getAvgWeight() => _avgWeight;
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
    _quantity = FormObjectItem();
    _animalType = FormObjectItem();
    _minWeight = FormObjectItem();
    _maxWeight = FormObjectItem();
    _avgWeight = FormObjectItem();
  }

  TrackAnimalForm.fromTrackAnimal(TrackAnimal trackAnimal) {
    fill(trackAnimal);
  }

  AnimalType? getAnimalTypeValue(){
    return  (_animalType.getValue()!=null)?(_animalType.getValue() as AnimalType):null;
  }

  int? getQuantityValue(){
    if(_quantity.getValue() !=null )
      return  _quantity.getValue() as int;
  }

  double? getMinWeightValue(){
    if(_minWeight.getValue() !=null )
      return  _minWeight.getValue() as double;
  }

  double? getMaxWeightValue(){
    if(_maxWeight.getValue() !=null )
      return  _maxWeight.getValue() as double;
  }

  double? getAvgWeightValue(){
    if(_avgWeight.getValue() !=null )
      return  _avgWeight.getValue() as double;
  }

  TrackAnimal buildTrackAnimal(){
    TrackAnimal track = TrackAnimal.empty();

    AnimalType? animalType =  getAnimalTypeValue();
    track.typeId = animalType?.id;
    track.typeDesc = animalType?.type?.label;

    int quantity = _quantity.getValue() as int;
    track.quantity = quantity;

    double? minWeight = getMinWeightValue();
    double? maxWeight = getMaxWeightValue();
    double? avgWeight = getAvgWeightValue();

    track.avgWeight = avgWeight;
    track.maxWeight = maxWeight;
    track.minWeight = minWeight;

    return track;
  }

  void fill(TrackAnimal trackAnimal){
    AnimalType anymalType = AnimalType(id: trackAnimal.typeId??0);

    getAnimalType().setValue(anymalType);
    getQuantity().setValue(trackAnimal.quantity);
    getMinWeight().setValue(trackAnimal.minWeight);
    getMaxWeight().setValue(trackAnimal.maxWeight);
    getAvgWeight().setValue(trackAnimal.avgWeight);

  }
}
