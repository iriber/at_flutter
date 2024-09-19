

import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_state.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/menu_item_company_drawer.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuItemUserDrawer extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          Widget bodyWidget;
          switch(state.status){
            case LoginStatus.success:{
              bodyWidget = _buildUsername(state);
            }break;
            case LoginStatus.alreadyLogged:{
              bodyWidget = _buildUsername(state);
            }break;
            default:{
              bodyWidget = SizedBox.shrink();
            }
          }
          return bodyWidget;
        });
  }

  Widget _buildUsername(LoginState state){

    String name =  "${state.user?.name}";

    Widget row = Row(children: [
      Padding(padding: EdgeInsets.only(top: 10, bottom: 10), child: ATIcons().getIconAccount(null, 70)),
      Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: EdgeInsets.only(left: 10), child: Text(name, style: ATFonts().menuSettingsTitle)),
            MenuItemCompanyDrawer()
        ])
      )
    ]);

    Widget body = Container(child: row);


    return body;

  }
}