import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/nav_app_title.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_form.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/tracks_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/tracks_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/tracks_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_edit_select_type.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_edit_set_date.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_edit_livestock_select_type.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_list.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_error_msg.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_loading_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fiona_layout/src/presentation/layouts/ifiona_appbar_layout_page.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class TrackAddPage extends StatelessWidget implements IFionaAppBarLayoutPage {

  String? title;

  TrackAddPage(BuildContext context, {Key? key}) : super(key: key) {
   BlocProvider.of<TrackAddBloc>(context).add((const InitTrackAddRequested()));
   //DependencyManager().get<CompanySelectBloc>().add((const FetchAllCompaniesRequested()));
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(

        child: ATAppBarLayout.likePopup(this, onClose: _onWillPop)
    );

  }

  Future<bool> _onWillPop(BuildContext context) async {
    ATErrorMessage.cleanMessages();

    //TODO preguntar si quiere irse y/ guardar los cambios

    return true;
  }

  @override
  Widget buildBody(BuildContext context) {

    return BlocConsumer<TrackAddBloc, TrackAddState>(
        listener: (context, state) {
          switch(state.status){
            case TrackAddStatus.success:{
              NavHelper().back(context);
            }break;
            /*case TrackAddStatus.failure:{
              //TODO show message.???
            }break;*/
          //TODO next step.
            default: break;
          }
        },
        builder: (context, state) {

          Widget bodyWidget ;
          switch(state.status){
            case TrackAddStatus.initial:{
              bodyWidget = _buildFormStep1(context, state);
            }break;
            case TrackAddStatus.sending:{
              bodyWidget = _buildFormStep1(context, state);
            }break;
            case TrackAddStatus.selectTrackType:{
              bodyWidget = _buildFormStep2(context, state);
            }break;
            case TrackAddStatus.selectLivestockType:{
              bodyWidget = _buildFormStep3(context, state);
            }break;
            case TrackAddStatus.failure:{
              bodyWidget = _buildFailure(context, state);
            }break;
            default:{
              bodyWidget = const Center();
            }
          }
          return Container(
            //color: Environment().config.appTheme.getBodyBackgroundColor() ,
              child: bodyWidget
          );
        }
    );
  }

  String getTitle(){
    return Fionai18n.message("tracks.add.title");
  }


  Widget _buildFailure(BuildContext context, TrackAddState state) {
    return TrackEditSetDate(state);
  }

  Widget _buildFormStep1(BuildContext context, TrackAddState state) {
    return TrackEditSetDate(state);
  }

  Widget _buildFormStep2(BuildContext context, TrackAddState state) {
    Paddock? paddock = (state.form?.getPaddock().getValue()?? Paddock.empty()) as Paddock?;
    if(paddock!=null && paddock.name.isNotEmpty){
      String subtitle = paddock.name;
      NavAppTitle.changeTitle(context, getTitle(), subtitle:  subtitle);
    }
    return TrackEditSelectType(state);
  }

  Widget _buildFormStep3(BuildContext context, TrackAddState state) {
    Paddock? paddock = (state.form?.getPaddock().getValue()?? Paddock.empty()) as Paddock?;
    if(paddock!=null && paddock.name.isNotEmpty){
      String subtitle = paddock.name;
      NavAppTitle.changeTitle(context, getTitle(), subtitle:  subtitle);
    }
    return TrackEditLivestockSelectType(state);
  }
}