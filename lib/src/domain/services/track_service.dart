import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/track_repository.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class TrackService {

  final FionaLogger logger = DependencyManager().get<FionaLogger>();
  final TrackRepository repository = DependencyManager().get<TrackRepository>();

  Future<List<Track>> getTracks(Farm farm) async{
    return repository.getAll(farm);
  }

  Future<Track> addTrack(Track track) async{
    return repository.add(track);
  }

}