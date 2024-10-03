import 'package:agro_tracking_flutter/src/domain/track_food.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_food_form.dart';
import 'package:equatable/equatable.dart';

enum TrackAddFoodStatus {
  initial, sending, success, failure }

class TrackAddFoodState extends Equatable {

  final TrackAddFoodStatus status;
  final TrackFoodForm? form;

  String? message;

  TrackFood getTrackFood(){
    return form?.buildTrackFood()??TrackFood.empty();
  }

  TrackAddFoodState({
    this.status = TrackAddFoodStatus.initial,
    this.form,
    this.message="",
  });

  TrackAddFoodState copyWith({
    TrackAddFoodStatus Function()? status,
    TrackFoodForm Function()? form,
    String Function()? message
  }) {
    return TrackAddFoodState(
      status: status != null ? status() : this.status,
      form: form != null ? form() : this.form,
      message: message != null ? message() : this.message,
    );
  }

  TrackAddFoodState copyWithoutMessage({
    TrackAddFoodStatus Function()? status,
    TrackFoodForm Function()? form,
  }) {
    return TrackAddFoodState(
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