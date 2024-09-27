import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_form.dart';
import 'package:equatable/equatable.dart';

enum TrackAddStatus {
  initial,
  dateSuccess, dateFailure,
  selectTrackType, selectLivestockType,

  sending, success, failure }

class TrackAddState extends Equatable {

  final TrackAddStatus status;
  final Farm? farm;
  final TrackForm? form;

  String? message;

  TrackAddState({
    this.status = TrackAddStatus.initial,
    this.farm,
    this.form,
    this.message="",
  });

  TrackAddState copyWith({
    TrackAddStatus Function()? status,
    TrackForm Function()? form,
    Farm Function()? farm,
    String Function()? message
  }) {
    return TrackAddState(
      status: status != null ? status() : this.status,
      form: form != null ? form() : this.form,
      farm: farm != null ? farm() : this.farm,
      message: message != null ? message() : this.message,
    );
  }

  TrackAddState copyWithoutMessage({
    TrackAddStatus Function()? status,
    TrackForm Function()? form,
    Farm Function()? farm,
  }) {
    return TrackAddState(
      status: status != null ? status() : this.status,
      form: form != null ? form() : this.form,
      farm: farm != null ? farm() : this.farm,
    );
  }

  @override
  List<Object?> get props => [
    status,
    form,
    farm,
    message
  ];
  
}