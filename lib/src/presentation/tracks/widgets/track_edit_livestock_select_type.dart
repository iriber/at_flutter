import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
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

class TrackEditLivestockSelectType extends StatelessWidget{

  FionaLogger logger = DependencyManager().get<FionaLogger>();

  TrackAddState state;


  TrackEditLivestockSelectType(this.state) {

  }

  @override
  Widget build(BuildContext context) {
    bool isSending = (this.state.status==LoginStatus.sending);

    List<Widget> widgets = List.empty(growable: true);

    if (state.status == TrackAddStatus.failure) {
      widgets.add(ATErrorMessage(errorMsg: state.form?.getError()?? ""));
    }

    AppTheme appTheme = Environment().config.appTheme;

    widgets.add(_buildLink(context, Fionai18n.message("track.animal"), ATIcons().getIconAnimal(appTheme.getBodyForegroundColor(), 100), 1, Colors.yellow));
    widgets.add(_buildLink(context, Fionai18n.message("track.food"), ATIcons().getIconFood(appTheme.getBodyForegroundColor(), 100), 1, Colors.green));
    widgets.add(_buildLink(context, Fionai18n.message("track.water"), ATIcons().getIconWater(appTheme.getBodyForegroundColor(), 100), 1, Colors.blue));


    widgets.add(
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
                    ),/*
                ATPrimaryButton(
                        width: 170,
                        label: (isSending?Fionai18n.message("sending"):Fionai18n.message("save")),
                        onTap:(BuildContext context){
                          if(!isSending){
                            doNext(context);
                          }
                        }
                    )*/
              ],
            )
        )
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

/*
  void doNext(BuildContext context) {

    TrackForm form = this.state.form??TrackForm.empty();
    BlocProvider.of<TrackAddBloc>(context).add((TrackAddRequested(form)));

  }*/

  void doPrevious(BuildContext context) {
    //BlocProvider.of<TrackAddBloc>(context).add((InitTrackAddRequested(form:state.form)));
    BlocProvider.of<TrackAddBloc>(context).add((TrackSetDateRequested(state.form??TrackForm.empty())));
  }


  Widget _buildLink(BuildContext context, String title, Widget icon, double percentage, Color color ) {
    return Container(
      //color: Colors.grey,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Padding(padding: EdgeInsets.only(right: 30)),
            Padding(padding: const EdgeInsets.only(bottom: 10), child: icon),
            Padding(padding: const EdgeInsets.all(3), child:
            Text(title)
            )
            //buildPercentage(context, percentage, color, icon)
          ],
        )
    );
  }
}
