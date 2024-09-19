import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/menu.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/services/farm_service.dart';
import 'package:agro_tracking_flutter/src/domain/services/menu_service.dart';
import 'package:agro_tracking_flutter/src/domain/services/track_service.dart';
import 'package:agro_tracking_flutter/src/domain/services/user_service.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class FacadeService {

  FionaLogger logger = DependencyManager().get<FionaLogger>();

  final MenuService menuService = MenuService();
  final UserService userService = UserService();
  final FarmService farmService = FarmService();
  final TrackService trackService = TrackService();

  
  Future<User> login(String email, String password)async{
    return userService.login(email, password);
  }

  Future<List<Menu>> getMainMenu() async{
    return menuService.getMainMenu();
  }

  Future<List<Menu>> getSidebarMenu() async{
    return menuService.getSidebarMenu();
  }

  Future<List<Farm>> getFarms(User user) async{
    return farmService.getFarms(user);
  }

  Future<List<Track>> getTracks(Farm farm) async{
    return trackService.getTracks(farm);
  }

  Future<Track> addTrack(Track track) async{
    return trackService.addTrack(track);
  }

  Future<List<Paddock>> findPaddocks({String? name, required Farm farm}) async{
    return farmService.findPaddocks( name: name, farm:farm);
  }

}