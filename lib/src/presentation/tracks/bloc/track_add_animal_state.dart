import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_animal_form.dart';
import 'package:equatable/equatable.dart';

enum TrackAddAnimalStatus {
  initial, sending, success, failure }

class TrackAddAnimalState extends Equatable {

  final TrackAddAnimalStatus status;
  //final Farm? farm;
  final TrackAnimalForm? form;

  String? message;

  TrackAddAnimalState({
    this.status = TrackAddAnimalStatus.initial,
    this.form,
    this.message="",
  });

  TrackAddAnimalState copyWith({
    TrackAddAnimalStatus Function()? status,
    TrackAnimalForm Function()? form,
    String Function()? message
  }) {
    return TrackAddAnimalState(
      status: status != null ? status() : this.status,
      form: form != null ? form() : this.form,
      message: message != null ? message() : this.message,
    );
  }

  TrackAddAnimalState copyWithoutMessage({
    TrackAddAnimalStatus Function()? status,
    TrackAnimalForm Function()? form,
  }) {
    return TrackAddAnimalState(
      status: status != null ? status() : this.status,
      form: form != null ? form() : this.form,
    );
  }

  @override
  List<Object?> get props => [
    status,
    form,
    message
  ];
  
}