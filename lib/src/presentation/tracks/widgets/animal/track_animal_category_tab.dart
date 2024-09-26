import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/presentation/helpers/animal_type_select_controller.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_animal_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_animal_form.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_error_msg.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_select_field.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fiona_i18n/fiona_i18n.dart';

class TrackAnimalCategoryTab extends StatelessWidget{

  bool rememberMe = false;
  TextEditingController quantityController = TextEditingController();
  TextEditingController minWeightController = TextEditingController();
  TextEditingController maxWeightController = TextEditingController();
  TextEditingController avgWeightController = TextEditingController();
  late AnimalTypeSelectController animalTypeSelectController;
  TrackAddAnimalState state;
  AnimalType? animalType ;

  TrackAnimalCategoryTab(this.state) {
    animalTypeSelectController = AnimalTypeSelectController();
    animalType = this.state.form?.getAnimalType().getValue();
    animalTypeSelectController.setSelected(animalType);

    quantityController.text =  this.state.form?.getQuantity().getValue()?.toString()??"" ;
    minWeightController.text =  this.state.form?.getMinWeight().getValue()?.toString()??"" ;
    maxWeightController.text =  this.state.form?.getMaxWeight().getValue()?.toString()??"" ;
    avgWeightController.text =  this.state.form?.getAvgWeight().getValue()?.toString()??"" ;
  }
  @override
  Widget build(BuildContext context) {

    bool isSending = (this.state.status==TrackAddAnimalStatus.sending);

    List<Widget> widgets = List.empty(growable: true);

    if (state.status == TrackAddAnimalStatus.failure) {
     // widgets.add(ATErrorMessage(errorMsg: state.form?.getError()?? ""));
    }

    widgets.add(Container(
      padding: const EdgeInsets.all(10),
      child: ATSelectField(
        enableSearch: false,
        fillAllItems: true,
        selectFieldController: animalTypeSelectController,
        label: Fionai18n.message("track.animal.type"),
        error: state.form?.getAnimalType().errorMessage,
       // prefixIcon: ATIcons().inputTextIconEmail(),
      ),
    ));

    widgets.add(Container(
      padding: const EdgeInsets.all(10),
      child: ATTextField(
        labelPosition: ATTextFieldLabelPosition.left,
        labelAlign: TextAlign.end,
        labelSize: 6,
        inputTextAlign: TextAlign.right,
        inputType: TextInputType.number,
        controller: quantityController,
        enabled: (!isSending),
        label: Fionai18n.message("track.animal.quantity"),
        error: state.form?.getQuantity().errorMessage,
        //prefixIcon: ATIcons().inputTextIconHashtag(),
      ),
    ));


    widgets.add(Container(
        padding: const EdgeInsets.all(10),
        child:ATTextField(
          labelPosition: ATTextFieldLabelPosition.left,
          labelSize: 6,
          labelAlign: TextAlign.end,
          inputTextAlign: TextAlign.right,
          inputType: TextInputType.number,
          controller: minWeightController,
          enabled: (!isSending),
          label: Fionai18n.message("track.animal.minWeight"),
          error: state.form?.getMinWeight().errorMessage,
          //prefixIcon: ATIcons().inputTextIconHashtag(),
        ))
    );

    widgets.add(Container(
      padding: const EdgeInsets.all(10),
      child:ATTextField(
        labelPosition: ATTextFieldLabelPosition.left,
        labelSize: 6,
        labelAlign: TextAlign.end,
        inputTextAlign: TextAlign.right,
        inputType: TextInputType.number,
              controller: maxWeightController,
              enabled: (!isSending),
              label: Fionai18n.message("track.animal.maxWeight"),
              error: state.form?.getMaxWeight().errorMessage,
             // prefixIcon: ATIcons().inputTextIconHashtag(),
            ))
    );

    widgets.add(Container(
        padding: const EdgeInsets.all(10),
        child:ATTextField(
          labelPosition: ATTextFieldLabelPosition.left,
          labelSize: 6,
          labelAlign: TextAlign.end,
          inputTextAlign: TextAlign.right,
          inputType: TextInputType.number,
          controller: avgWeightController,
          enabled: (!isSending),
          label: Fionai18n.message("track.animal.avgWeight"),
          error: state.form?.getAvgWeight().errorMessage,
          //prefixIcon: ATIcons().inputTextIconHashtag(),
        ))
    );


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




  void fillForm(TrackAnimalForm form) {

    AnimalType? animalType = animalTypeSelectController.getSelected();
    form.getAnimalType().setValue( animalType );
    form.getQuantity().parse( quantityController.text );
    form.getMinWeight().parse( minWeightController.text );
    form.getMaxWeight().parse( maxWeightController.text );
    form.getAvgWeight().parse( avgWeightController.text );

  }

}
