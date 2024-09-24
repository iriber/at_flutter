
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/services/facade_service.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_select_field.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class AnimalTypeSelectController extends ATSelectFieldController{

  final FacadeService _service = DependencyManager().get<FacadeService>() ;

  AnimalTypeSelectController({selected});

  Future<List<AnimalType>> findItems(String text) async {

    return _service.findAnimalTypes(name: text);

  }

  @override
  String getItemLabel(item) {
    return item.type?.label;
  }

  AnimalType? getSelected() {
    return selected;
  }

}
