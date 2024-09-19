

import 'package:agro_tracking_flutter/src/domain/farm.dart';

abstract class FarmSelectEvent {
  const FarmSelectEvent();

}

class FetchAllFarmsRequested extends FarmSelectEvent {

  const FetchAllFarmsRequested();

}

class SelectFarmRequested extends FarmSelectEvent {

  final Farm _farm;

  const SelectFarmRequested(this._farm);

  Farm getFarm() => _farm;

}

class UnselectFarmRequested extends FarmSelectEvent {

  const UnselectFarmRequested();

}

