import 'package:agro_tracking_flutter/src/domain/paddock.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/nav_app_title.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_form.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/animal/track_edit_animal_list.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/food/track_edit_food_list.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_edit_breadcrumb.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fiona_layout/src/presentation/layouts/ifiona_appbar_layout_page.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class TrackAddFoodListPage extends StatelessWidget implements IFionaAppBarLayoutPage {

  String? title;
  late TrackAddState state;
  TrackAddFoodListPage(BuildContext context, {Key? key}) : super(key: key) {
   //BlocProvider.of<TrackAddBloc>(context).add((InitTrackAddRequested()));
   //DependencyManager().get<CompanySelectBloc>().add((const FetchAllCompaniesRequested()));
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(

        child: ATAppBarLayout.likePopup(this, onClose: _onBack, iconBack: ATIcons().iconBack,)
    );

  }

  void _onBack(BuildContext context) {

    TrackForm form = state.form??TrackForm.empty();
    BlocProvider.of<TrackAddBloc>(context).add((TrackSetTrackTypeRequested(form)));

  }

  @override
  Widget buildBody(BuildContext context) {

    return BlocConsumer<TrackAddBloc, TrackAddState>(
        listener: (context, state) {


          switch(state.status){
            case TrackAddStatus.success:{
              //NavHelper().back(context);
            }break;
            /*case TrackAddStatus.failure:{
              //TODO show message.???
            }break;*/
          //TODO next step.
            default: break;
          }
        },
        builder: (context, state) {

          this.state=state;
          Widget  bodyWidget = _buildFormStepEditTrackFoods(context, state) ;


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



  Widget _buildFormStepEditTrackFoods(BuildContext context, TrackAddState state) {


    return Column(
        children: [
          Expanded(child: _buildBreadcrumb(context,state ), flex: 1,),
          Expanded(child: TrackEditFoodList(state),flex: 9,)
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
        items.add(TrackEditBreadcrumbItem(Fionai18n.message("track.livestock")));break;
      case TrackType.agriculture:
        items.add(TrackEditBreadcrumbItem(Fionai18n.message("track.agriculture")));break;
      default: break;

    }
    items.add(TrackEditBreadcrumbItem(Fionai18n.message("track.food")));

    return TrackEditBreadcrumb(breadcrumbs: items);
  }
}