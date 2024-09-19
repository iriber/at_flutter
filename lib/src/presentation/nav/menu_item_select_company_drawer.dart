

import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_state.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/model/menu_item.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/right_drawer_menu_item.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuItemSelectCompanyDrawer extends StatelessWidget{

  MenuItemSelectCompanyDrawer();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FarmSelectBloc, FarmSelectState>(
        builder: (context, state) {
          Widget widget;

          if( state.hasCompanySelected() ){
            widget = _buildMenu(context, state.selectedFarm);
          }else{
            widget = _buildMenu(context,null);
          }
          return Container(
            child: widget,
          );
        });

  }

  Widget _buildMenu(BuildContext context, Farm? company){

    String itemDesc = (company?.name??"").isEmpty?"Seleccionar campo":"Cambiar campo";
    MenuSectionItem menuItem = MenuSectionItem(code: PagesConfig.selectFarmMenuCode,
        icon:  ATIcons().getIconByName("select-company", size: 25, color: ATSideMenuStyles.menuIconColor),
        title: itemDesc,
        link: PagesConfig.selectFarmLink);

      Color sectionForegroundColor = Environment().config.appTheme.getBodyForegroundColor();
    return RigthDrawerMenuItem(item:menuItem, backColor: sectionForegroundColor, textColor: sectionForegroundColor);



  }

}