import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_animal_form.dart';

abstract class TrackAddAnimalEvents {
  const TrackAddAnimalEvents();
}

class InitTrackAnimalAddRequested extends TrackAddAnimalEvents {
  final TrackAnimalForm? form;
  const InitTrackAnimalAddRequested({this.form});
  TrackAnimalForm? getForm() => form;
}

class TrackAddAnimalRequested extends TrackAddAnimalEvents {
  final TrackAnimalForm form;
  const TrackAddAnimalRequested(this.form);
  TrackAnimalForm getForm() => form;
}

