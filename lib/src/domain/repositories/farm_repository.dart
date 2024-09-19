

import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

abstract class FarmRepository {

  Future<List<Farm>> getAll(User user);

  Future<Farm> add(Farm entity);

  Future<bool> update(Farm entity);

  Future<bool> remove(Farm entity);

  Future<void> sync(List<Farm> farms);

}