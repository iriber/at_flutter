import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:equatable/equatable.dart';

enum TracksStatus { initial, loading, success, failure }

class TracksState extends Equatable {

  final TracksStatus status;
  final List<Track> tracks;
  final Farm? farm;
  String? message;

  TracksState({
    this.status = TracksStatus.initial,
    this.tracks = const [],
    this.farm,
    this.message="",
  });

  TracksState copyWith({
    TracksStatus Function()? status,
    List<Track> Function()? tracks,
    Farm Function()? farm,
    String Function()? message
  }) {
    return TracksState(
      status: status != null ? status() : this.status,
      tracks: tracks != null ? tracks() : this.tracks,
      farm: farm != null ? farm() : this.farm,
      message: message != null ? message() : this.message,
    );
  }

  TracksState copyWithoutMessage({
    TracksStatus Function()? status,
    List<Track> Function()? tracks,
    Farm Function()? farm
  }) {
    return TracksState(
      status: status != null ? status() : this.status,
      tracks: tracks != null ? tracks() : this.tracks,
      farm: farm != null ? farm() : this.farm,
    );
  }

  @override
  List<Object?> get props => [
    status,
    tracks,
    farm,
    message
  ];
  
}