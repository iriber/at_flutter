import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/presentation/helpers/paddock_select_controller.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_events.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_form.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_state.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_form.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/animal/track_animal_item.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_button.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_calendar_field.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_checkbox.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_datetime_field.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_dropdown_field.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_error_msg.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_select_field.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_text_field.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fiona_i18n/fiona_i18n.dart';

import 'package:fiona_logger/src/log/fiona_logger.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TrackEditAnimal extends StatelessWidget{

  FionaLogger logger = DependencyManager().get<FionaLogger>();

  TrackAddState state;

  TrackEditAnimal(this.state) {

  }
  Widget build(BuildContext context){

    return Column(
      children: [
        Expanded(
          child: buildCategories(context),
          flex: 5),
        Expanded(
            child: buildFooter(context),
            flex: 1),
      ],
    ) ;
  }



  Widget buildFooter(BuildContext context){
    bool isSending = (this.state.status==LoginStatus.sending);
    return
        Container(
            padding: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ATPrimaryButton(
                    width: 170,
                    label: (isSending?Fionai18n.message("sending"):Fionai18n.message("previous")),
                    onTap:(BuildContext context){
                      if(!isSending){
                        doPrevious(context);
                      }
                    }
                )
              ],
            )
        );

  }

  Widget buildCategories(BuildContext context) {

    return CupertinoScrollbar(

      child: Column(

        children: [
          for (final trackAnimal in state.form?.tracks??List.empty())
            TrackAnimalItem(
              trackAnimal: trackAnimal,
              onSelect: (context, company) {
                //TODO mostrar para editarla
              },
            ),

           Padding(
               padding: EdgeInsets.only(top: 10),
             child: ATSecondaryBorderedButton(
                 width: double.infinity,
                 label:Fionai18n.message("track.animal.add"),
                 onTap:(BuildContext context){
                     NavHelper().navToPageLink(context, PagesConfig.trackingAnimalAddLink);
                 }
             ),
           ),
        ],
      ),
    );
  }

  void doPrevious(BuildContext context) {
    BlocProvider.of<TrackAddBloc>(context).add((TrackSetTrackTypeRequested(state.form??TrackForm.empty())));
  }
}
