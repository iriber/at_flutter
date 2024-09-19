

import 'package:agro_tracking_flutter/src/domain/farm.dart';

abstract class TracksEvent {
  const TracksEvent();

}

class FetchAllTracksRequested extends TracksEvent {

  const FetchAllTracksRequested();
}

