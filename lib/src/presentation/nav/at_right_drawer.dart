import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_events.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_events.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/menu_item_select_company_drawer.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/menu_item_company_drawer.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/menu_item_user_drawer.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_loading_spinner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:agro_tracking_flutter/src/domain/menu.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_events.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_state.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/model/menu_item.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/right_drawer_menu_item.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_styles.dart';
import 'package:url_launcher/url_launcher.dart';

import 'nav_helper.dart';


class ATRigthDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<MenuBloc, MenuState>(
        builder: (context, state) {
          Widget widget;
          switch (state.status) {
            case MenuStatus.initial:
              {
                BlocProvider.of<MenuBloc>(context)
                    .add((const FetchAllMenusRequested()));
                widget = _buildLoading(context);
              }
              break;
            case MenuStatus.loading:
              {
                widget = _buildLoading(context);
              }
              break;
            case MenuStatus.failure:
              {
                widget = _buildFailure(context, state);
              }
              break;
            case MenuStatus.success:
              {
                widget = buildMenu(context, state);
              }
              break;
            default:
              widget = buildMenu(context, state);
          }
          ;

          return widget;
        });
  }

  Widget _buildLoading(BuildContext context) => Drawer(
      elevation: 16,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          ATLoadingSpinner(),
          _buildFooter(context),
        ],
      ));

  Widget _buildFailure(BuildContext context, MenuState state) => Drawer(
      elevation: 16,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          _buildFooter(context),
        ],
      ));

  Widget buildMenu(BuildContext context, MenuState state) => Drawer(
      elevation: 16,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          _buildMenuSection(context, state),
          _buildFooter(context),
        ],
      ));


  Widget _buildFooter(BuildContext context) {
    return  Positioned(
      bottom: 10,
      child: Container(
          width: 200,
          padding: const EdgeInsets.all(5),
          child:Column(
            children: [
              ListTile(
                //iconColor: ATSideMenuStyles.menuIconColor,
                leading: ATIcons().getIconSignedOut(ATSideMenuStyles.menuIconColor, 25),
                title: Text('Sign out', style: ATSideMenuStyles.textMenuItem),
                onTap: () {
                  onSignoutTap(context);
                },
              ),
              //Text("Version "+ Environment().config.appVersion,style: TextStyle(fontSize: 12),)
            ],
          ) ),
    );
  }

  Widget _buildMenuSection(BuildContext context, MenuState state) {

    List<Widget> widgets = List.empty(growable: true);
    Color sectionForegroundColor = Environment().config.appTheme.getBodyForegroundColor();

    widgets.add(Padding(
        padding: EdgeInsets.fromLTRB(10, 40, 0, 0),
        child: MenuItemUserDrawer()));

    widgets.add(Divider(height: 4));

    widgets.add(Divider(height: 3.0));
    widgets.add(
        MenuItemSelectCompanyDrawer()
    );
    widgets.add(Divider(height: 5, thickness: 5,));

    state.sidebarMenu.forEach((Menu atMenu) {
      widgets.add(Divider(height: 3.0));
      widgets.add(
          _buildMenuSectionItem(
              context,
              MenuSectionItem(code: atMenu.code,
                  icon:  ATIcons().getIconByName(atMenu.icon, size: 25, color: ATSideMenuStyles.menuIconColor),
                  title: atMenu.label,
                  link: atMenu.link,
                  args: atMenu.buildLinkArgs(context))
          )
      );
    });

    widgets.add(Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
        child: GestureDetector(
          onTap: ()async{
            String email = Uri.encodeComponent(Environment().config.atSupportEmail);
            String subject = Uri.encodeComponent("AT Support");
            //String body = Uri.encodeComponent("Hi! I'm Flutter Developer");
            print(subject); //output: Hello%20Flutter
            Uri mail = Uri.parse("mailto:$email?subject=$subject");
            if (await launchUrl(mail)) {
              //email app opened
            }else{
              //email app is not opened
            }
          },
          child:ListTile(
            iconColor: ATSideMenuStyles.menuIconColor,
            leading: ATIcons().iconSupport,
            title: Text(
                Environment().config.atSupportEmail,
                style: ATSideMenuStyles.getTextMenuItem(color:Environment().config.appTheme.getBodyForegroundColor())
            ),
          ),
        )));


    return Container(
        color: Environment().config.appTheme.getTertiaryBackgroundColor(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widgets,
        ));
  }


  RigthDrawerMenuItem _buildMenuSectionItem(BuildContext context, MenuSectionItem? item) {
    Color sectionForegroundColor = Environment().config.appTheme.getBodyForegroundColor();
    return RigthDrawerMenuItem(item: item, backColor: sectionForegroundColor, textColor: sectionForegroundColor);
  }

  void onSignoutTap(BuildContext context) {

    BlocProvider.of<LoginBloc>(context).add((LogoutRequested()));
    BlocProvider.of<FarmSelectBloc>(context).add(UnselectFarmRequested());

    NavHelper().navToLogin(context);
  }

  void navToPageLink(BuildContext context, String pageLink){
    NavHelper().navToPageLink(context, pageLink);
    Future.delayed(Duration(milliseconds: 100), () {
      Scaffold.of(context).closeEndDrawer();
    });
  }

}
/*
class ATUserRigthDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ATLoginBloc, ATLoginState>(
    builder: (context, state) {
      Widget bodyWidget  = Text(
        "${state.user?.CustomerName}",
        style: ATFonts().menuSettingsTitle,
      );
      switch(state.status){
        case ATLoginStatus.success:{
          bodyWidget = _buildUsername(state);
        }break;
        case ATLoginStatus.alreadyLogged:{
          bodyWidget = _buildUsername(state);
        }break;
        default:{
          bodyWidget = SizedBox.shrink();
        }
      }
      return bodyWidget;
    });
  }

  Widget _buildUsername(ATLoginState state){
    return Text(
      "${state.user?.CustomerName}",
      style: ATFonts().menuSettingsTitle,
    );
  }
}*/