import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_events.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_state.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/widgets/farm_list.dart';
import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_error_msg.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_loading_list.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_loading_spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fiona_layout/src/presentation/layouts/ifiona_appbar_layout_page.dart';
import 'package:fiona_i18n/fiona_i18n.dart';

class FarmSelectPage extends StatelessWidget implements IFionaAppBarLayoutPage {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  FarmSelectPage(BuildContext context, {Key? key}) : super(key: key) {
   BlocProvider.of<FarmSelectBloc>(context).add((const FetchAllFarmsRequested()));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        child: ATAppBarLayout.likePopup(this, onClose: _onWillPop)
    );

  }

  Future<bool> _onWillPop(BuildContext context) async {
    ATErrorMessage.cleanMessages();

    //BlocProvider.of<CompanySelectBloc>(context).add((const CheckSpecialsForCurrentEventRequested()));

    return true;
  }
  Widget buildBody(BuildContext context) {
    return BlocConsumer<FarmSelectBloc, FarmSelectState>(
      listener: (context, state) {
        if (state.status == FarmSelectStatus.farmSelected) {
          NavHelper().navToHome(context);
        }
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
          case FarmSelectStatus.initial:
            {
              BlocProvider.of<FarmSelectBloc>(context).add((const FetchAllFarmsRequested()));
              widget = _buildLoadingPage(context);
            }
            break;
          case FarmSelectStatus.loading:
            {
              widget = _buildLoadingPage(context);
            }
            break;
          case FarmSelectStatus.failure:
            {
              widget = _buildPage(context, List.empty());
            }
            break;
          case FarmSelectStatus.success:
            {
              widget = _buildPage(context, state.farms);
            }
            break;
          default:
            widget = _buildPage(context, List.empty());
        }
       return RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: () async {
              BlocProvider.of<FarmSelectBloc>(context).add((const FetchAllFarmsRequested()));
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
    return Fionai18n.message("companySelect.title");
  }


  Widget _buildLoadingPage(BuildContext context) {
    return ATLoadingList();
  }

  Widget _buildPage(BuildContext context, List<Farm> companies) {
    return FarmList(companies);
  }


}