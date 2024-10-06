

import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';

abstract class TrackRepository {

  Future<List<Track>> getAll(Farm farm);

  Future<Track> save(Track entity);

  Future<Track> add(Track entity);

  Future<bool> update(Track entity);

  Future<bool> remove(Track entity);

  Future<void> sync(List<Track> tracks);

}