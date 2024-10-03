

import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/domain/lot.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/domain/track_food.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_animal_type_item.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_double_item.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_int_item.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_lot_item.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_object_item.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class TrackFoodForm{

  FormLotItem _lot = FormLotItem();
  FormDoubleItem _hectares = FormDoubleItem();
  FormIntItem _consumptionPerAnimal = FormIntItem();


  TrackFoodForm();

  String? _error;

  FormLotItem getLot() => _lot;
  FormDoubleItem getHectares() => _hectares;
  FormIntItem getConsumptionPerAnimal() => _consumptionPerAnimal;
  String? getError() => _error;

  bool validate(){
    bool lotRequired =  _lot.checkEmpty(msg:Fionai18n.message("lot.required"));
    if(lotRequired){
      _error = Fionai18n.message("fields.required");
    }
    //_error = Fionai18n.message("fields.required");
    return !lotRequired;
  }

  TrackFoodForm.empty() {
    _lot = FormLotItem();
    _hectares = FormDoubleItem();
    _consumptionPerAnimal = FormIntItem();
  }

  TrackFoodForm.fromTrackFood(TrackFood trackFood) {
    fill(trackFood);
  }

  Lot? getLotValue(){
    return  (_lot.getValue()!=null)?(_lot.getValue() as Lot):null;
  }

  TrackFood buildTrackFood(){
    TrackFood track = TrackFood.empty();


    Lot? lot = _lot.getValue();
    track.lotId = lot?.id;
    track.lotDesc = lot?.name;

    track.hectares = _hectares.getValue();
    track.consumptionPerAnimal = _consumptionPerAnimal.getValue();

    return track;
  }

  void fill(TrackFood trackFood){

    getLot().parse(trackFood.lotId, trackFood.lotDesc);
    getHectares().setValue(trackFood.hectares);
    getConsumptionPerAnimal().setValue(trackFood.consumptionPerAnimal);

  }
}
