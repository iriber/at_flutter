

import 'package:agro_tracking_flutter/src/domain/user.dart';

abstract class UserRepository {

  Future<User> getLoggedUser();

}