
import 'package:agro_tracking_flutter/src/data/persistence/dao/farm_dao.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/farm_repository.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/track_repository.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';
import 'package:intl/intl.dart';

class TrackInMemory implements TrackRepository{

  final FionaLogger logger = DependencyManager().get<FionaLogger>();

  List<Track> tracks = List.empty(growable: true);

  TrackInMemory(){
    Farm farm = Farm(id:1);

    Track track = Track(id:1, sync: true);
    //track.paddockId= 1;
    //track.paddockDesc="Potrero 1";
    track.datetime = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-06-20 08:30:00");
    track.farmId=1;
    tracks.add(track);


    track = Track(id:4, sync: true);
    //track.paddockId= 1;
    //track.paddockDesc="Potrero 1";
    track.farmId=1;
    track.datetime = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-07-09 08:30:00");
    tracks.add(track);

    track = Track(id:5, sync: true);
    //track.paddockId= 2;
    //track.paddockDesc="Potrero 2";
    track.farmId=1;
    tracks.add(track);

    track = Track(id:7, sync: true);
    //track.paddockId= 1;
    //track.paddockDesc="Potrero 1";
    track.farmId=1;
    track.datetime = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-08-09 08:30:00");
    tracks.add(track);

    track = Track(id:8, sync: true);
    //track.paddockId= 2;
    //track.paddockDesc="Potrero 2";
    track.farmId=1;
    track.datetime = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-08-09 10:30:00");
    tracks.add(track);

    track = Track(id:9, sync: true );
    //track.paddockId= 1;
    //track.paddockDesc="Potrero 1";
    track.farmId=1;
    track.datetime = DateFormat("yyyy-MM-dd HH:mm:ss").parse("2024-08-10 10:30:00");
    tracks.add(track);

  }

  @override
  Future<Track> add(Track entity) async{
    entity.localId = tracks.length+1;
    tracks.add(entity);
    return entity;
  }

  @override
  Future<List<Track>> getAll(Farm farm) async{
    await Future.delayed(const Duration(seconds: 1), () {

    });

    return tracks.where((element) => ((element.farmId??0)==farm.id)).toList();
  }

  @override
  Future<bool> remove(Track entity) async{
    tracks = tracks.where((element) => (element.id!=entity.id)).toList();
    return true;
  }

  @override
  Future<bool> update(Track entity) async{
    Track? track = await getByTrack(entity);
    if( track==null ){
      //throw error
      return false;
    }
    //guardo en memoria.
    track?.animalTracks = entity.animalTracks;
    track?.foodTracks = entity.foodTracks;
    track?.waterTracks = entity.waterTracks;
    track?.datetime = entity.datetime;

    return true;
  }

  @override
  Future<void> sync(List<Track> tracks) async{
    //TODO do sync HERE.

  }

  @override
  Future<Track> save(Track entity) async{

    if( entity.isNotEmpty() ){
      update(entity);
    }else{
      add(entity);
    }
    return entity;
  }

  Future<Track?> getById(int id, {int? localId}) async{
    await Future.delayed(const Duration(seconds: 1), () {

    });

    Track? result;
    if(id>0){
      result =  tracks.where((element) => (element.id==id)).toList().first;
    }else{
      result =  tracks.where((element) => (element.localId==localId)).toList().first;
    }
    return result;
  }
  Future<Track?> getByTrack(Track track) async{
    await Future.delayed(const Duration(seconds: 1), () {

    });

    Track? result;
    if(track.id>0){
      result =  tracks.where((element) => (element.id==track.id)).toList().first;
    }else{
      result =  tracks.where((element) => ( (element.localId==track.localId) && (element.farmId==track.farmId))).toList().first;
    }
    return result;
  }
}