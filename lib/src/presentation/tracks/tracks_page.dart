import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_events.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/tracks_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/tracks_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/tracks_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_list.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_error_msg.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_loading_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fiona_layout/src/presentation/layouts/ifiona_appbar_layout_page.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class TracksPage extends StatelessWidget implements IFionaAppBarLayoutPage {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  TracksPage(BuildContext context, {Key? key}) : super(key: key) {

   BlocProvider.of<TracksBloc>(context).add((const FetchAllTracksRequested()));
   //DependencyManager().get<CompanySelectBloc>().add((const FetchAllCompaniesRequested()));
  }

  @override
  Widget build(BuildContext context) {

    List<Widget> actions = List.empty(growable: true);
    actions.add(Builder(
      builder: (context) => IconButton(
        icon: ATIcons().iconAdd,
        onPressed: () => NavHelper().navToTrackingAdd(context),
      ),
    ));
    return ATAppBarLayout(this, backButton: true, actions: actions, settingsButton: false,);
  }

  Widget buildBody(BuildContext context) {
    return BlocConsumer<TracksBloc, TracksState>(
      listener: (context, state) {
        /*
        if (state.status == TracksStatus.farmSelected) {
          NavHelper().navToHome(context);
        }*/
       /* else if (state is ExampleFailure) {
          // Mostrar un mensaje de error
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('An error occurred')),
          );
        }*/
      },
      builder: (context, state) {
        Widget widget;
        switch (state.status) {
          case TracksStatus.initial:
            {
              BlocProvider.of<TracksBloc>(context).add((const FetchAllTracksRequested()));
              widget = _buildLoadingPage(context);
            }
            break;
          case TracksStatus.loading:
            {
              widget = _buildLoadingPage(context);
            }
            break;
          case TracksStatus.failure:
            {
              widget = _buildPage(context, List.empty());
            }
            break;
          case TracksStatus.success:
            {
              widget = _buildPage(context, state.tracks);
            }
            break;
          default:
            widget = _buildPage(context, List.empty());
        }
       return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              BlocProvider.of<TracksBloc>(context).add((const FetchAllTracksRequested()));
              //DependencyManager().get<CompanySelectBloc>().add((const FetchAllCompaniesRequested()));
            },
            triggerMode: RefreshIndicatorTriggerMode.anywhere,
            child: Container(
              //color: Environment().config.appTheme.getBodyBackgroundColor(),
              child: widget,
            )
        );
      },
    );
  }

  String getTitle(){
    return Fionai18n.message("tracks.title");
  }


  Widget _buildLoadingPage(BuildContext context) {
    return ATLoadingList(itemHeight: 80,);
  }

  Widget _buildPage(BuildContext context, List<Track> tracks) {
    //BlocProvider.of<AppTitleBloc>(context).add(TitleChangeRequested(getTitle()));
    return TrackList(tracks);
  }


}