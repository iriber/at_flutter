import 'dart:async';

import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

class ConnectivityService {

  FionaLogger logger = DependencyManager().get<FionaLogger>();

  Future<bool> checkInternetConnection() async {
    bool hasConnection = true;

    var result = await Connectivity().checkConnectivity();
    if(result == ConnectivityResult.mobile) {
      logger.d("Internet connection is from Mobile data");
    }else if(result == ConnectivityResult.wifi) {
      logger.d("internet connection is from wifi");
    }else if(result == ConnectivityResult.ethernet){
      logger.d("internet connection is from wired cable");
    }else if(result == ConnectivityResult.bluetooth){
      logger.d("internet connection is from bluethooth threatening");
    }else if(result == ConnectivityResult.none){
      logger.d("No internet connection");
      hasConnection = false;
    }

    return hasConnection;
  }

}