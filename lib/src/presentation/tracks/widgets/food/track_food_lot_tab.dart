import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/presentation/helpers/animal_type_select_controller.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_animal_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_food_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_animal_form.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_food_form.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_error_msg.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_percentage_field.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_select_field.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fiona_i18n/fiona_i18n.dart';

class TrackFoodLotTab extends StatelessWidget{

  bool rememberMe = false;
  TextEditingController hectaresController = TextEditingController();
  int? consumptionPerAnimal;
  TrackAddFoodState state;
  //AnimalType? animalType ;

  TrackFoodLotTab(this.state) {

    //animalType = this.state.form?.getAnimalType().getValue();
    //animalTypeSelectController.setSelected(animalType);

    hectaresController.text =  this.state.form?.getHectares().getValue()?.toString()??"" ;
    consumptionPerAnimal =  this.state.form?.getConsumptionPerAnimal().getValue();
  }

  @override
  Widget build(BuildContext context) {

    bool isSending = (this.state.status==TrackAddFoodStatus.sending);

    List<Widget> widgets = List.empty(growable: true);

    if (state.status == TrackAddFoodStatus.failure) {
     // widgets.add(ATErrorMessage(errorMsg: state.form?.getError()?? ""));
    }

    widgets.add(Container(
      padding: const EdgeInsets.all(10),
      child: ATTextField(
        labelPosition: ATTextFieldLabelPosition.left,
        labelAlign: TextAlign.end,
        labelSize: 6,
        inputTextAlign: TextAlign.right,
        inputType: TextInputType.number,
        controller: hectaresController,
        enabled: (!isSending),
        label: Fionai18n.message("track.food.hectares"),
        error: state.form?.getHectares().errorMessage,
        //prefixIcon: ATIcons().inputTextIconHashtag(),
      ),
    ));

    widgets.add(Container(
      padding: const EdgeInsets.all(10),
      child: AtPercentageField(
        labelPosition: AtPercentageFieldLabelPosition.left,
        //progressType: AtPercentageFieldProgressType.circular,
        labelAlign: TextAlign.end,
        labelSize: 4,
        value: consumptionPerAnimal,
        enabled: (!isSending),
        label: Fionai18n.message("track.food.consumptionPerAnimal"),
        error: state.form?.getConsumptionPerAnimal().errorMessage,
        onChange: (newValue){
          consumptionPerAnimal = newValue;
        },
        //prefixIcon: ATIcons().inputTextIconHashtag(),
      ),
    ));


    return Container(

        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: widgets,
              ),
            )
          ],
        ));
  }




  void fillForm(TrackFoodForm form) {

    form.getHectares().parse( hectaresController.text );
    form.getConsumptionPerAnimal().setValue(consumptionPerAnimal);

    debugPrint("getConsumptionPerAnimal: ${form.getConsumptionPerAnimal().getValue()}");
  }

}
