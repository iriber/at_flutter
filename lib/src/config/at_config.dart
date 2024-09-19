import 'dart:io';

import 'package:agro_tracking_flutter/src/data/farm/farm_remote.dart';
import 'package:agro_tracking_flutter/src/data/farm/farm_local.dart';
import 'package:agro_tracking_flutter/src/data/farm/farm_proxy.dart';
import 'package:agro_tracking_flutter/src/data/core/at_api.dart';
import 'package:agro_tracking_flutter/src/data/menu/menu_in_memory.dart';
import 'package:agro_tracking_flutter/src/data/paddock/paddock_local.dart';
import 'package:agro_tracking_flutter/src/data/paddock/paddock_proxy.dart';
import 'package:agro_tracking_flutter/src/data/paddock/paddock_remote.dart';
import 'package:agro_tracking_flutter/src/data/persistence/dao/farm_dao.dart';
import 'package:agro_tracking_flutter/src/data/persistence/dao/paddock_dao.dart';
import 'package:agro_tracking_flutter/src/data/persistence/sqlite/at_scheme.dart';
import 'package:agro_tracking_flutter/src/data/persistence/sqlite/sqlite_datatabase.dart';
import 'package:agro_tracking_flutter/src/data/proxies/data_proxy.dart';
import 'package:agro_tracking_flutter/src/data/track/track_in_memory.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/core/at_core_repository.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/menu_repository.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/paddock_repository.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/track_repository.dart';
import 'package:agro_tracking_flutter/src/domain/services/at_core_service.dart';
import 'package:agro_tracking_flutter/src/domain/services/farm_service.dart';
import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/domain/services/menu_service.dart';
import 'package:agro_tracking_flutter/src/domain/services/track_service.dart';
import 'package:agro_tracking_flutter/src/domain/services/user_service.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/farm_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'package:fiona_logger/src/log/fiona_logger.dart';
import 'package:fiona_logger/src/domain/log_data_repository.dart';
import 'package:fiona_logger/src/log/log_in_console.dart';

import 'package:fiona_persistence/src/data/persistence/fiona_persistence.dart';

abstract class ATConfig {

  //APP local database version
  int get appDatabaseVersion => 1;

  //App version
  String appVersion="";

  String get atSupportEmail => "support@agrotracking.com";

  //LOGGER
  String get logPath => "agrotracking.log";

  Level get loggerLevel;

  String documentsPath = "";

  String get atCoreApiHost;

  String get atCoreApiVersion => "v1";

  String get atTermsFilename => "files/terms.htm";
  String get atTermsUrl => "https://rekria.com/app-terms-of-service/";
  String get atPrivacyPolicyFilename => "files/privacy-policy.htm";
  String get atPrivacyPolicyUrl => "https://rekria.com/app-privacy-policy/";

  String get atCoreApiKey => "b6c80600-9c14-43f5-897f-782a749a3e9f";

  //App name (for the user agent)
  String get appNameForRekriaCoreAPI => "ATMobile";

  String get platform => (Platform.isAndroid)?"Android":"IOS";
  String get userAgent => "${appNameForRekriaCoreAPI} $platform v${appVersion}";

  AppTheme appTheme = AppTheme.empty();

  String getAppDocumentsPath() {
    return documentsPath;
  }

  Future<void> init() async {
    documentsPath = (await getApplicationDocumentsDirectory()).path;

    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = "${packageInfo.version}";

    injectDependencies();

    injectCrudDependencies();
  }

  bool isProd(){
    return false;
  }

  void injectCrudDependencies() {
    DependencyManager manager = DependencyManager();
    //CrudInjectDependency<Cow>().inject(manager, CowCrudHelper());
    //CrudInjectDependency<BullType>().inject(manager, BullTypeCrudHelper());
  }


  void injectDependencies() {
    try {
      
      DependencyManager manager = DependencyManager();

      manager.registerLazySingletonIfNotExist<FionaLogger>(() =>FionaLogger(level: this.loggerLevel));
      
      /* persistence dependencies */
      FionaPersistence localPersistence = SQLiteDatabase(ATScheme());
      manager.registerLazySingletonIfNotExist<FarmDAO>(() => FarmDAO(localPersistence));
      manager.registerLazySingletonIfNotExist<PaddockDAO>(() => PaddockDAO(localPersistence));

      /* repositories */
      manager.registerLazySingletonIfNotExist<LogDataRepository>(() => LogInConsole());
      manager.registerLazySingletonIfNotExist<ATCoreRepository>(() =>  ATApi());
      manager.registerLazySingletonIfNotExist<MenuRepository>(() => MenuInMemory());

      manager.registerLazySingletonIfNotExist<FarmRepository>(instanceName: DataProxy.local,() => FarmLocal());
      manager.registerLazySingletonIfNotExist<FarmRepository>(instanceName: DataProxy.remote,() => FarmRemote());
      manager.registerLazySingletonIfNotExist<FarmRepository>(() => FarmProxy());

      manager.registerLazySingletonIfNotExist<PaddockRepository>(instanceName: DataProxy.local,() => PaddockLocal());
      manager.registerLazySingletonIfNotExist<PaddockRepository>(instanceName: DataProxy.remote,() => PaddockRemote());
      manager.registerLazySingletonIfNotExist<PaddockRepository>(() => PaddockProxy());

      manager.registerLazySingletonIfNotExist<TrackRepository>(() => TrackInMemory());

      /* Services */
      manager.registerLazySingletonIfNotExist<UserService>(() => UserService());
      manager.registerLazySingletonIfNotExist<FarmService>(() => FarmService());
      manager.registerLazySingletonIfNotExist<MenuService>(() => MenuService());
      manager.registerLazySingletonIfNotExist<TrackService>(() => TrackService());
      manager.registerLazySingletonIfNotExist<ATCoreService>(() => ATCoreService());
      manager.registerLazySingletonIfNotExist<FacadeService>(() => FacadeService());
      

    } catch (e2) {
      debugPrint("Error en GetIt");
    }
  }

}
