import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/farm_repository.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/paddock_repository.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';

class FarmService {

  final FionaLogger logger = DependencyManager().get<FionaLogger>();
  final FarmRepository repository = DependencyManager().get<FarmRepository>();
  final PaddockRepository paddockRepository = DependencyManager().get<PaddockRepository>();

  Future<List<Farm>> getFarms(User user) async{
    return repository.getAll(user);
  }

  Future<List<Paddock>> findPaddocks({required Farm farm, String? name}) async{

    List<Paddock> results = await paddockRepository.getAll(farm);

    if(name!=null){
      results = results.where((paddock) {
        return paddock.name.toLowerCase().contains(name.toLowerCase());
      }).toList();
    }

    return results;

  }

}