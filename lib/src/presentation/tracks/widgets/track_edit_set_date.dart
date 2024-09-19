import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/presentation/helpers/paddock_select_controller.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_events.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_form.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_state.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_events.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/nav_app_title.dart';
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

class TrackEditSetDate extends StatelessWidget{

  FionaLogger logger = DependencyManager().get<FionaLogger>();

  bool rememberMe = false;
  DateTime? date;
  DateTime? time;
  Paddock? paddock;
  TrackAddState state;

  late PaddockSelectController paddockSelectController;

  TrackEditSetDate(this.state) {
    paddockSelectController = PaddockSelectController(farm: this.state.farm??Farm.empty());
    time = (this.state.form?.getTime().getValue()?? DateTime.timestamp()) as DateTime?;
    date = (this.state.form?.getDate().getValue()?? DateTime.timestamp()) as DateTime?;
    paddock = (this.state.form?.getPaddock().getValue()?? Paddock.empty()) as Paddock?;
    paddockSelectController.setSelected(paddock);
  }

  @override
  Widget build(BuildContext context) {
    bool isSending = (this.state.status==LoginStatus.sending);

    List<Widget> widgets = List.empty(growable: true);

    if (state.status == TrackAddStatus.failure) {
      widgets.add(ATErrorMessage(errorMsg: state.form?.getError()?? ""));
    }

/*
    widgets.add(Container(
      padding: const EdgeInsets.all(10),
      child: ATSelectField(
        selectFieldController: paddockSelectController,
        label: Fionai18n.message("paddock"),
        //error: loginState.form?.getEmail().errorMessage,
        //prefixIcon: ATIcons().inputTextIconEmail(),
      ),
    ));
*/

    widgets.add(Container(
      padding: const EdgeInsets.all(10),
      child: AtDatetimeField(
        initialDatetime: time,
        onChanged:(newDatetime){
          time = newDatetime;
        } ,
        label: Fionai18n.message("time"),
        error: state.form?.getTime().errorMessage,
        //prefixIcon: ATIcons().inputTextIconEmail(),
      ),
    ));

    widgets.add(Container(
      padding: const EdgeInsets.all(10),
      child: ATCalendarField(
        initialDates: [date],
        onChanged:(newDates){
          date = newDates.first;

        } ,
        label: Fionai18n.message("date"),
        error: state.form?.getDate().errorMessage,
        //prefixIcon: ATIcons().inputTextIconEmail(),
      ),
    ));

    widgets.add(
        Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 80),
            child: ATPrimaryButton(
                width: 170,
                label: (isSending?Fionai18n.message("sending"):Fionai18n.message("start")),
                onTap:(BuildContext context){
                  if(!isSending){
                    doNext(context);
                  }
                }
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


  void doNext(BuildContext context) {

    Paddock paddock = paddockSelectController.getSelected();

    logger.d("do next!");
    logger.d("date: ${date}");
    logger.d("paddock: ${paddock}");
    logger.d("time ${time}");

    TrackForm form = this.state.form??TrackForm.empty();

    form.getPaddock().setValue( paddock );
    form.getDate().setValue( date );
    form.getTime().setValue( time );
    //form.getPassword().value = password;

    BlocProvider.of<TrackAddBloc>(context).add(TrackSetDateRequested(form));

  }


}
