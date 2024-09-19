import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/at_app_bar.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_theme_data.dart';
import 'package:flutter/material.dart';

import 'package:fiona_layout/src/presentation/layouts/ifiona_layout_page.dart';

class ATLoginLayout extends StatelessWidget{

  IFionaLayoutPage page;
  bool withAppBar;

  ATLoginLayout(this.page, {this.withAppBar=false});

  @override
  Widget build(BuildContext context) {

    return buildLayout(context);

  }

  @override
  Widget buildLayout(BuildContext context) {

    Scaffold scaffold = buildScaffold(
      context,
      appBar: (this.withAppBar?buildAppBar(context):null),
      widgets: buildScaffoldWidgets(context),
    );

    Theme theme = buildTheme(scaffold, Environment().config.appTheme);

    return theme;
  }

  @override
  List<Widget> buildScaffoldWidgets(BuildContext context) {

    Widget logo = buildLogo(context);
    Widget body = buildBody(context);

    return [
      Expanded(
        flex: 3,
        child: logo,
      ),
      Expanded(
          flex: 8,
          child: body
      )
    ];
  }

  Scaffold buildScaffold(BuildContext context, {required List<Widget> widgets, AppBar? appBar}){
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
    );
  }

  Theme buildTheme(Scaffold scaffold, AppTheme appTheme){
    return Theme(
        data: ATThemeData().buildTheme(appTheme),
        child: scaffold
    );
  }

  Widget buildBody(BuildContext context) {
    return page.buildBody(context);
  }

  AppBar? buildAppBar(BuildContext context){
    return ATAppBar.build(
        context:context,
        menuButton: false,
        backButton: false);
  }


  Widget buildLogo(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 0, top: 50),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("AT Logo Here", style: TextStyle(fontSize: 40),)
          //Image(image: AssetImage('assets/images/cow_1602197.png'), height: 150)
        ],
      )
    );
  }

}