import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_form.dart';

abstract class TrackAddEvent {
  const TrackAddEvent();
}

class InitTrackAddRequested extends TrackAddEvent {
  final TrackForm? form;
  const InitTrackAddRequested({this.form});

  TrackForm? getForm() => form;
}

class TrackSetDateRequested extends TrackAddEvent {
  final TrackForm _form;

  const TrackSetDateRequested(this._form);

  TrackForm getForm() => _form;

}

class TrackSetTrackTypeRequested extends TrackAddEvent {
  final TrackForm _form;

  const TrackSetTrackTypeRequested(this._form);

  TrackForm getForm() => _form;

}


class TrackSetLivestockTypeRequested extends TrackAddEvent {
  final TrackForm _form;

  const TrackSetLivestockTypeRequested(this._form);

  TrackForm getForm() => _form;

}


class TrackAddRequested extends TrackAddEvent {
  final TrackForm _form;

  const TrackAddRequested(this._form);

  TrackForm getForm() => _form;

}

