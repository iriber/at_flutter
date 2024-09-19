
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_select_field.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class PaddockSelectController extends ATSelectFieldController{

  final FacadeService _service = DependencyManager().get<FacadeService>() ;

  Farm farm;

  PaddockSelectController({required this.farm});

  Future<List<Paddock>> findItems(String text) async {

    return _service.findPaddocks(name: text, farm: farm);

  }

  Paddock getSelected() {
    return selected??Paddock(name: textNotFound??"");
  }

}
