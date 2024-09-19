import 'package:agro_tracking_flutter/src/presentation/nav/app_title/nav_app_title.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:flutter/material.dart';


class ATAppBar extends AppBar{

  static Widget getTitleWidget(BuildContext context,String titleString){
    //return Text(titleString, style: ATFonts().appBarTitle,);
    return NavAppTitle(context,titleString);
  }

  ATAppBar(
      { double toolbarHeight=50,
        List<Widget>? actions,
        //required String title,
        required Widget title,
        bool centerTitle=true,
        Color? backgroundColor,
        double elevation=10,
        Widget? leading,
        double leadingWidth=56,
        Color? foregroundColor}
  ):super(toolbarHeight: toolbarHeight,
    actions: actions,
    title: title,
    centerTitle: centerTitle,
    backgroundColor: backgroundColor,
    elevation: elevation,
    leading: leading,
    leadingWidth: leadingWidth,
    foregroundColor: foregroundColor);


  factory ATAppBar.build({
    required BuildContext context,
    bool backButton = false,
    String customIconBackLabel="",
    Widget? customIconBack,
    Widget? customIconMenu,
    String titleString = "",
    List<Widget> customActions = const <Widget>[],
    bool menuButton = true,
    Function(BuildContext context)? onClose
  }) {

    Widget iconMenu=customIconMenu??ATIcons().iconMenu;
    Widget iconBack = customIconBack??ATIcons().iconBack;

    titleString = (titleString??"");

    return ATAppBar(
      toolbarHeight: 50,
      actions: buildRigthActions(context, menuButton, iconMenu, customActions),
      title:  getTitleWidget(context,titleString),
      centerTitle: true,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      elevation: 10,
      leading: buildLeftBtn(context, backButton, customIconBackLabel, iconBack, onClose),
      leadingWidth: (customIconBackLabel.isNotEmpty)?100:56,
      foregroundColor: Colors.white,
    );
  }

  static List<Widget>? buildRigthActions(BuildContext context, bool menuButton, Widget iconMenu, List<Widget> customActions){
    List<Widget> actions = List.empty(growable: true);

    if (customActions.isNotEmpty) {
      customActions.addAll(actions);
      actions = customActions;
    }

    if(menuButton){
      actions.add(Builder(
        builder: (context) => IconButton(
          icon: iconMenu,
          onPressed: () => Scaffold.of(context).openEndDrawer(),
        ),
      ));
    }

    //if( MediaQuery.of(context).size.width < 600 )
      return actions;

  }


  static Widget buildIconBackButton(BuildContext context, Widget iconBack, Function(BuildContext context)? onClose){
    return IconButton(
      icon: iconBack,
      tooltip: 'Back',
      color: Theme.of(context).appBarTheme.foregroundColor,
      onPressed: () {
          pressIconBack(context, onClose);
      },
    );
  }

  static Future<void> pressIconBack (BuildContext context, Function(BuildContext context)? onClose) async {
    if(onClose!=null){
      onClose!(context);
    }
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      NavHelper().navToHome(context);
     /*
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MenuPage())
      );*/
    }
  }

  static Widget? buildLeftBtn(
      BuildContext context, bool backButton, String iconBackLabel, Widget iconBack, Function(BuildContext context)? onClose) {

    if (backButton) {
      if(iconBackLabel.isNotEmpty){
        return
          Row(children: [
            buildIconBackButton(context, iconBack, onClose),
            GestureDetector(
                onTap:(){
                  pressIconBack(context, onClose);
                } ,
                child:Text(iconBackLabel)
            )
          ],);
      }else{
        return buildIconBackButton(context, iconBack, onClose);
      }
    }
  }

}