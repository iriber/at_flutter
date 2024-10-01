import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/nav_app_title.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/animal/track_edit_animal_list.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_edit_breadcrumb.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_edit_select_type.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_edit_set_date.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_edit_livestock_select_type.dart';
import 'package:agro_tracking_flutter/src/utils/at_dialog_utils.dart';
import 'package:agro_tracking_flutter/src/utils/at_messages_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fiona_layout/src/presentation/layouts/ifiona_appbar_layout_page.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class TrackAddPage extends StatelessWidget implements IFionaAppBarLayoutPage {

  String? title;

  TrackAddPage(BuildContext context, {Key? key}) : super(key: key) {
   //BlocProvider.of<TrackAddBloc>(context).add((const InitTrackAddRequested()));
   //DependencyManager().get<CompanySelectBloc>().add((const FetchAllCompaniesRequested()));
  }

  @override
  Widget build(BuildContext context) {

    return ATAppBarLayout.likePopup(this, onClose: _onWillPop);

  }

  Future<bool> _onWillPop(BuildContext context) async {
    return await AtDialogUtils().showConfirmDialog(context)??false;
  }

  @override
  Widget buildBody(BuildContext context) {

    return BlocConsumer<TrackAddBloc, TrackAddState>(

        listener: (context, state) {
          switch(state.status){
            case TrackAddStatus.success:{
              NavHelper().back(context);
            }break;
            case TrackAddStatus.failure:{
              ATMessagesUtils.errorMessage(state.message);
            }break;
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

          _setTitle(context,state);
          return Container(
            //color: Environment().config.appTheme.getBodyBackgroundColor() ,
              child: bodyWidget
          );
        }
    );
  }

  String getTitle(){

    return Fionai18n.message("tracks.add.title").replaceAll("{farm}", "");;
  }


  Widget _buildFailure(BuildContext context, TrackAddState state) {
    return TrackEditSetDate(state);
  }

  Widget _buildFormStep1(BuildContext context, TrackAddState state) {



    return TrackEditSetDate(state);
  }

  Widget _buildFormStep2(BuildContext context, TrackAddState state) {

    return TrackEditSelectType(state);
  }

  Widget _buildFormStep3(BuildContext context, TrackAddState state) {

    return Column(
      children: [
        Expanded(child: _buildBreadcrumb(context,state ),flex: 1,),
        Expanded(child: TrackEditLivestockSelectType(state),flex: 9,)
    ]);
  }

  Widget _buildFormStepEditTrackAnimals(BuildContext context, TrackAddState state) {


    return Column(
        children: [
          Expanded(child: _buildBreadcrumb(context,state ), flex: 1,),
          Expanded(child: TrackEditAnimalList(state),flex: 9,)
        ]);

  }

  void _setTitle(BuildContext context, TrackAddState state) {
    String title = Fionai18n.message("tracks.add.title");
    title=title.replaceAll("{farm}", state.farm?.name??"");
    NavAppTitle.changeTitle(context, title);

  }

  TrackEditBreadcrumb _buildBreadcrumb(BuildContext context, TrackAddState state) {
    List<TrackEditBreadcrumbItem> items = List.empty(growable: true);

    Paddock? paddock = (state.form?.getPaddock().getValue()?? Paddock.empty()) as Paddock?;
    if(paddock!=null && paddock.name.isNotEmpty){
      items.add(TrackEditBreadcrumbItem(paddock.name));
    }

    switch( state.form?.trackType ){
      case TrackType.empty:
        break;
      case TrackType.livestock:
        items.add(TrackEditBreadcrumbItem("Ganadería"));break;
      case TrackType.agriculture:
        items.add(TrackEditBreadcrumbItem("Agricultura"));break;
      default: break;

    }

    switch( state.form?.trackLivestockType ){
      case TrackLivestockType.empty:
        break;
      case TrackLivestockType.animal:
        items.add(TrackEditBreadcrumbItem("Animal"));break;
      case TrackLivestockType.food:
        items.add(TrackEditBreadcrumbItem("Alimento"));break;
      case TrackLivestockType.water:
        items.add(TrackEditBreadcrumbItem("Agua"));break;
      default: break;
    }

    return TrackEditBreadcrumb(breadcrumbs: items);
  }
}