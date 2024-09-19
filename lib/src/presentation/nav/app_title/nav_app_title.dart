
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_state.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_events.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_state.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class NavAppTitle extends StatelessWidget  {

  String title;
  String? subtitle;

  NavAppTitle(BuildContext context,this.title,{this.subtitle}){
    BlocProvider.of<AppTitleBloc>(context).add(DefaultTitleRequested());
  }

  static void changeTitle(BuildContext context,String title,{String? subtitle}){
    BlocProvider.of<AppTitleBloc>(context).add(TitleChangeRequested(title, subtitle:  subtitle));
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AppTitleBloc, AppTitleState>(
        builder: (context, state) {
          Widget widget;
          switch (state.status) {
            case AppTitleStatus.defaultTitle:
              {
                widget = _buildTitle(context, this.title);
              }
              break;
            case AppTitleStatus.titleChanged:
              {
                widget = _buildTitle(context, state.title??"");
              }
              break;
            default:
              widget = _buildTitle(context, "");
          }
          return widget;
        }
        );
  }

  Widget _buildTitle(BuildContext context, String title) {
    //return Text(title, style: ATFonts().appBarTitle,);
    return Column( children: [
      //Text("La Escondida", style: ATFonts().appBarTitle,),
      Text(title, style: ATFonts().appBarTitle,)
    ],);
  }


}