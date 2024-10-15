
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/domain/track_food.dart';
import 'package:agro_tracking_flutter/src/domain/track_water.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_object_item.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_paddock_item.dart';
import 'package:fiona_i18n/fiona_i18n.dart';
import 'package:flutter/gestures.dart';

class TrackForm{

  FormPaddockItem _paddock = FormPaddockItem();
  FormObjectItem _date = FormObjectItem();
  FormObjectItem _time = FormObjectItem();

  Track? originalTrack;
  TrackType? trackType;
  TrackLivestockType? trackLivestockType;
  List<TrackAnimal>? tracksAnimal;
  List<TrackFood>? tracksFood;
  List<TrackWater>? tracksWater;

  TrackForm(this._paddock, this._date, this._time);

  String? _error;

  FormPaddockItem getPaddock() => _paddock;
  FormObjectItem getDate() => _date;
  FormObjectItem getTime() => _time;
  String? getError() => _error;

  bool validate(){
    bool isValid=true;
    //isValid = isValid && !this._email.checkEmpty(msg:Fionai18n.message("email.required"));
    //isValid = isValid && !this._password.checkEmpty(msg:Fionai18n.message("password.required"));
    _error = Fionai18n.message("fields.required");
    return isValid;
  }

  TrackForm.empty() {
    _date = FormObjectItem();
    _time = FormObjectItem();
    _paddock = FormPaddockItem();
  }

  void fill(Track track){

    originalTrack = track;
    _time.value = track.datetime;
    _date.value = track.datetime;
    tracksAnimal= track.animalTracks;
    tracksFood = track.foodTracks;
    tracksWater = track.waterTracks;

  }

  Track buildTrack(){
    Track track = originalTrack??Track.empty();
    /*Paddock? paddock = _paddock.getValue();
    track.paddockId = paddock?.id;
    track.paddockDesc = paddock?.name;*/
    DateTime time = _time.getValue() as DateTime;
    DateTime date = _date.getValue() as DateTime;
    date.copyWith(hour: time.hour,minute: time.minute,second: time.second,millisecond: 0,microsecond: 0);
    track.datetime = date;

    track.animalTracks = tracksAnimal;
    track.foodTracks = tracksFood;
    track.waterTracks = tracksWater;

    return track;
  }

  void editTrackAnimal(TrackAnimal trackAnimal){
    if(tracksAnimal==null){
      tracksAnimal = List.empty(growable: true);
      tracksAnimal?.add(trackAnimal);
    }else{
      //check if exists.
      bool exists = false;
      TrackAnimal? previous;

      for(var element in (getTracksAnimalCurrentPaddock())){
        exists = (element.typeId == trackAnimal.typeId);
        if(exists){
          previous = element;
          break;
        }
      }
      if(exists){
        previous?.updateWith(trackAnimal);
      }else{
        tracksAnimal?.add(trackAnimal);
      }
    }
  }

  void editTrackFood(TrackFood trackFood){
    if(tracksFood==null){
      tracksFood = List.empty(growable: true);
      tracksFood?.add(trackFood);
    }else{
      //check if exists.
      bool exists = false;
      TrackFood? previous;
      for(var element in (getTracksFoodCurrentPaddock())){
        exists = (element.lotId == trackFood.lotId);
        if(exists){
          previous = element;
          break;
        }
      }
      if(exists){
        previous?.updateWith(trackFood);

      }else{
        tracksFood?.add(trackFood);
      }
    }
  }
  List<TrackAnimal> getTracksAnimalCurrentPaddock(){
    Paddock? paddock = _paddock.getValue();
    return getTracksAnimal(paddock??Paddock.empty());
  }
  List<TrackFood> getTracksFoodCurrentPaddock(){
    Paddock? paddock = _paddock.getValue();
    return getTracksFood(paddock??Paddock.empty());
  }
  List<TrackWater> getTracksWaterCurrentPaddock(){
    Paddock? paddock = _paddock.getValue();
    return getTracksWater(paddock??Paddock.empty());
  }
  List<TrackAnimal> getTracksAnimal(Paddock paddock){
    List<TrackAnimal> result = List.empty(growable: true);
    tracksAnimal?.forEach((item){
      if(item.paddockId==paddock.id){
        result.add(item);
      }

    });
    return result;
  }
  List<TrackFood> getTracksFood(Paddock paddock){
    List<TrackFood> result = List.empty(growable: true);
    tracksFood?.forEach((item){
      if(item.paddockId==paddock.id){
        result.add(item);
      }

    });
    return result;
  }
  List<TrackWater> getTracksWater(Paddock paddock){
    List<TrackWater> result = List.empty(growable: true);
    tracksWater?.forEach((item){
      if(item.paddockId==paddock.id){
        result.add(item);
      }

    });
    return result;
  }

  void addTrackFood(TrackFood trackFood) {
    if(tracksFood==null){
      tracksFood = List.empty(growable: true);
      tracksFood?.add(trackFood);
    }else{
      //check if exists.
      bool exists = false;
      TrackFood? previous;
      for(var element in (getTracksFoodCurrentPaddock())){
        exists = (element.lotId == trackFood.lotId);
        if(exists){
          previous = element;
          break;
        }
      }
      if(!exists){
        tracksFood?.add(trackFood);
      }
    }
  }
}
