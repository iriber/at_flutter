import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/generic_model.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

abstract class RemoteData<T extends GenericModel>{

  final FionaLogger logger = DependencyManager().get<FionaLogger>();

  Future<List<T>> getAll();

}