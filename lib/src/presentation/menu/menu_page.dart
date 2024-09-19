import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_loading_spinner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agro_tracking_flutter/src/domain/menu.dart';
import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_events.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_state.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/widgets/menu_widget.dart';

import 'package:fiona_layout/src/presentation/layouts/ifiona_appbar_layout_page.dart';

class MenuPage extends StatelessWidget implements IFionaAppBarLayoutPage {


  @override
  Widget build(BuildContext context) {
    return ATAppBarLayout(this);//, menuButton: true,);
  }

  @override
  Widget buildBody(BuildContext context) {
    return BlocConsumer<MenuBloc, MenuState>(
        listener: (context, state) {
          switch(state.status){
            case MenuStatus.loginRequired:{
              NavHelper().navToLogin(context);
            }break;
            default: break;
          }
        },
        builder: (context, state) {

          Widget widget;
          switch (state.status) {
            case MenuStatus.initial:
              {
                BlocProvider.of<MenuBloc>(context)
                    .add((const FetchAllMenusRequested()));
                widget = _buildLoadingPage(context);
              }
              break;
            case MenuStatus.loading:
              {
                widget = _buildLoadingPage(context);
              }
              break;
            case MenuStatus.failure:
              {
                widget = _buildPage(context, List.empty());
              }
              break;
            case MenuStatus.success:
              {
                widget = _buildPage(context, state.mainMenu);
              }
              break;
            default:
              widget = _buildPage(context, List.empty());
          }
          return widget;
        }
    );
  }

  String getTitle(){
    return "Home";
  }

  Widget _buildLoadingPage(BuildContext context) {
    return ATLoadingSpinner();
  }

  Widget _buildPage(BuildContext context, List<Menu> menuSettings) {
    return Container(
      child: MenuWidget(menuSettings: menuSettings),
    );
  }


}
