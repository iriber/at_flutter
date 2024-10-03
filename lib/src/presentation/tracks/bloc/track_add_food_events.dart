import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_food_form.dart';

abstract class TrackAddFoodEvents {
  const TrackAddFoodEvents();
}

class InitTrackFoodAddRequested extends TrackAddFoodEvents {
  final TrackFoodForm? form;
  const InitTrackFoodAddRequested({this.form});
  TrackFoodForm? getForm() => form;
}

class TrackAddFoodRequested extends TrackAddFoodEvents {
  final TrackFoodForm form;
  const TrackAddFoodRequested(this.form);
  TrackFoodForm getForm() => form;
}

