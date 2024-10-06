import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
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

class TrackEditSelectPaddock extends StatelessWidget{

  FionaLogger logger = DependencyManager().get<FionaLogger>();

  TrackAddState state;
  late PaddockSelectController paddockSelectController;
  Paddock? paddock;


  TrackEditSelectPaddock(this.state) {
    paddockSelectController = PaddockSelectController(farm: this.state.farm??Farm.empty());
    paddock = (this.state.form?.getPaddock().getValue()?? Paddock.empty()) as Paddock?;
    paddockSelectController.setSelected(paddock);
  }

  @override
  Widget build(BuildContext context) {
    bool isSending = (this.state.status==LoginStatus.sending);

    List<Widget> widgets = List.empty(growable: true);


    AppTheme appTheme = Environment().config.appTheme;

    widgets.add(Container(
      padding: const EdgeInsets.all(10),
      child: ATSelectField(
       // enableSearch: false,
        fillAllItems: true,
        selectFieldController: paddockSelectController,
        label: Fionai18n.message("paddock"),
        //error: loginState.form?.getEmail().errorMessage,
        //prefixIcon: ATIcons().inputTextIconEmail(),
      ),
    ));

    /*
    widgets.add(
        GestureDetector(
          onTap: (){
            TrackForm form = this.getForm(context);
            form.trackType = TrackType.livestock;
            form.trackLivestockType = null;
            BlocProvider.of<TrackAddBloc>(context).add((TrackSetTrackTypeRequested(form)));
          },
          child: _buildLink(context, Fionai18n.message("track.livestock"), ATIcons().getIconAnimal(appTheme.getBodyForegroundColor(), 100), 1, Colors.yellow),
        )

    );

    widgets.add(
        GestureDetector(
          onTap: (){
            TrackForm form = this.getForm(context);
            form.trackType = TrackType.agriculture;
            form.trackLivestockType = null;
            BlocProvider.of<TrackAddBloc>(context).add((TrackSetTrackTypeRequested(form)));
          },
          child: _buildLink(context, Fionai18n.message("track.agriculture"), ATIcons().getIconFood(appTheme.getBodyForegroundColor(), 100), 1, Colors.green),
        )

    );
   */


    widgets.add(
        Container(
            padding: const EdgeInsets.only(top: 50),
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
                    ),
                ATPrimaryButton(
                        width: 170,
                        label: (isSending?Fionai18n.message("sending"):Fionai18n.message("next")),
                        onTap:(BuildContext context){
                          if(!isSending){
                            doNext(context);
                          }
                        }
                    )
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


  TrackForm getForm(BuildContext context) {

    TrackForm form = this.state.form??TrackForm.empty();

    Paddock paddock = paddockSelectController.getSelected();
    form.getPaddock().setValue( paddock );

    return form;

  }

  void doPrevious(BuildContext context) {
    BlocProvider.of<TrackAddBloc>(context).add((InitTrackAddRequested(form:getForm(context))));
  }
  void doNext(BuildContext context) {
    BlocProvider.of<TrackAddBloc>(context).add((TrackSetPaddockRequested(getForm(context))));
  }





}
