
import 'package:agro_tracking_flutter/src/data/exceptions/at_exception.dart';

class ConnectivityException extends AtException{

  ConnectivityException({String message = 'Connectivity Exception'}) : super(message:message);
}