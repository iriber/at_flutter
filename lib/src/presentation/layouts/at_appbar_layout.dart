import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/widgets/farm_subtitle.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_events.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/at_app_bar.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/at_right_drawer.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:flutter/material.dart';
import 'package:fiona_layout/src/presentation/layouts/fiona_appbar_layout.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ATAppBarLayout extends FionaAppBarLayout{

  List<Widget>? actions;
  Widget? customHeader;
  bool hideHeader=false;

  ATAppBarLayout(super.page,{super.backButton=false, this.actions, super.settingsButton, this.customHeader, this.hideHeader=false}){

  }//, {this.actions, super.floatingActionBtn, super.menuButton=false});

  ATAppBarLayout.likePopup(page, {this.customHeader, this.hideHeader=true, Function(BuildContext context)? onClose}):super.likePopup(page, onClose: onClose, settingsButton: false ){
    this.customIconBack = ATIcons().iconClose;
  }

  Widget? buildRigthDrawer(BuildContext context){
    if(this.settingsButton){
      return ATRigthDrawer();
    }
  }

  AppBar? buildAppBar(BuildContext context, String pageTitle){
    return ATAppBar.build(
        context:context,
        titleString: pageTitle,
        backButton: this.backButton,
        menuButton: this.settingsButton,
        customIconBack: this.customIconBack,
        customActions: actions??[],
        onClose: this.onClose,
      );
  }

  Widget buildBody(BuildContext context) {

    Widget body = super.buildBody(context);

    if( hideHeader ){
      return body;
    }

    Widget header = buildHeader(context);

    return Column(
      children: [
        Expanded(
          flex: 2,
          child: header,
        ),
        Expanded(
            flex: 19,
            child: body
        )
        /*Expanded(
          flex: 1,
          child: footer
      ),*/
      ],
    );

  }

  Widget buildHeader(BuildContext context) {
    return this.customHeader??FarmSubtitle();
  }

  @override
  List<Widget> buildScaffoldWidgets(BuildContext context) {

    Widget body = buildBody(context);
    Widget footer = buildFooter();

    return [
      Expanded(
          flex: 10,
          child: body
      ),
      Expanded(
          flex: 0,
          child: footer
      ),
    ];
  }

  Scaffold buildScaffold(BuildContext context, {required List<Widget> widgets, AppBar? appBar}){

    // FunPassIcons

    return Scaffold(
      appBar: appBar,
      body:  Container(
          decoration: BoxDecoration(
            color: Environment().config.appTheme.getBodyBackgroundColor(),
            image: DecorationImage(
                image: AssetImage("assets/images/agro_tracking_grey_bg.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter
            ),
          ),
          //color: Colors.black,
          child:
          Column(
            children: widgets,
          )
      ),
      endDrawer: buildRigthDrawer(context),
    );
  }
}
