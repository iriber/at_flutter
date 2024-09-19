import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/data/persistence/dao/farm_dao.dart';
import 'package:agro_tracking_flutter/src/data/persistence/sqlite/upgrades/command_script_v1.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:fiona_persistence/src/data/persistence/fiona_persistence_scheme.dart';
import 'package:fiona_persistence/src/data/persistence/scheme/command_script.dart';

/**
 * This class create the scheme and manage the upgrading.
 */
class ATScheme extends FionaPersistenceScheme{


  @override
  String getSchemeName() {
    return "at_database.db";
  }

  @override
  String getPath() {
    return Environment().config.getAppDocumentsPath();
  }

  @override
  int getSchemeVersion() {
    return Environment().config.appDatabaseVersion;
  }

  @override
  void initializeCommands() {
    versionCommands[1] = _buildV1Commands();
  }

  /**
   * command scripts for Version 1
   */
  List<CommandScript> _buildV1Commands() {
    List<CommandScript> commands = List.empty(growable: true);
    commands.addAll( CommandScriptV1().builCommands() ) ;
    return commands;
  }

}