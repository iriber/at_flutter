

import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';

abstract class PaddockRepository {

  Future<List<Paddock>> getAll(Farm farm);

  Future<Paddock> add(Paddock entity);

  Future<bool> update(Paddock entity);

  Future<bool> remove(Paddock entity);

  Future<void> sync(List<Paddock> paddocks);

}