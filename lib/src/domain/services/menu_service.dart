import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/menu.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/menu_repository.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class MenuService {

  MenuRepository menuRepository =  DependencyManager().get<MenuRepository>();

  FionaLogger logger = DependencyManager().get<FionaLogger>();

  Future<List<Menu>> getMainMenu() async{

    return menuRepository.getMainMenu();

  }

  Future<List<Menu>> getSidebarMenu() async{

    return menuRepository.getSidebarMenu();

  }

}