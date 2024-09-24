
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/utils/forms/form_object_item.dart';
import 'package:fiona_i18n/fiona_i18n.dart';
import 'package:flutter/gestures.dart';

class TrackForm{

  FormObjectItem _paddock = FormObjectItem();
  FormObjectItem _date = FormObjectItem();
  FormObjectItem _time = FormObjectItem();

  TrackType? trackType;
  TrackLivestockType? trackLivestockType;
  List<TrackAnimal>? tracks;

  TrackForm(this._paddock, this._date, this._time);

  String? _error;

  FormObjectItem getPaddock() => _paddock;
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
    _paddock = FormObjectItem();
  }

  Track buildTrack(){
    Track track = Track.empty();
    Paddock paddock = _paddock.getValue() as Paddock;
    track.paddockId = paddock.id;
    track.paddockDesc = paddock.name;
    DateTime time = _time.getValue() as DateTime;
    DateTime date = _date.getValue() as DateTime;
    date.copyWith(hour: time.hour,minute: time.minute,second: time.second,millisecond: 0,microsecond: 0);
    track.datetime = date;

    return track;
  }

  void editTrackAnimal(TrackAnimal trackAnimal){
    if(tracks==null){
      tracks = List.empty(growable: true);
      tracks?.add(trackAnimal);
    }else{
      //check if exists.
      bool exists = false;
      TrackAnimal? previous;
      tracks?.forEach((element) {
        exists = (element.typeId == trackAnimal.typeId);
        if(exists){
          previous = element;
        }
      });

      if(exists){
        previous?.quantity = trackAnimal.quantity;
        previous?.minWeight = trackAnimal.minWeight;
        previous?.maxWeight = trackAnimal.maxWeight;
        previous?.avgWeight = trackAnimal.avgWeight;
        //previous?.typeId = trackAnimal.typeId;
        //previous?.typeDesc = trackAnimal.typeDesc;
      }else{
        tracks?.add(trackAnimal);
      }

    }
    //tracks?.add(trackAnimal);
  }

}
