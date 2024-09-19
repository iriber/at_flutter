import 'package:agro_tracking_flutter/src/data/persistence/dao/farm_dao.dart';
import 'package:agro_tracking_flutter/src/data/persistence/dao/paddock_dao.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:fiona_persistence/src/data/persistence/scheme/command_script.dart';

/**
 * Command to create the first version of the database.
 */
class CommandScriptV1{


  List<CommandScript> builCommands() {
    List<CommandScript> commands = List.empty(growable: true);
    commands.add( CommandScript( DependencyManager().getIt<FarmDAO>().createSQL) ) ;
    commands.add( CommandScript( DependencyManager().getIt<PaddockDAO>().createSQL) ) ;
    return commands;
  }

}