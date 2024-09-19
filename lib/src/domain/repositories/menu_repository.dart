

import 'package:agro_tracking_flutter/src/domain/menu.dart';

abstract class MenuRepository {

  Future<List<Menu>> getMainMenu();

  Future<List<Menu>> getSidebarMenu();
}