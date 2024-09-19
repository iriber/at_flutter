
import 'package:fiona_logger/src/log/fiona_logger.dart';


import 'at_config.dart';
class ATDevConfig extends ATConfig {

  @override
  String get atCoreApiHost => "http://localhost:8081/";

  @override
  Level get loggerLevel => Level.debug;

}
