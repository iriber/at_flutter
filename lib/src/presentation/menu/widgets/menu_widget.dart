
import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/menu_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/model/menu_item.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/model/menu_section.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/widgets/menu_widget_item.dart';

import '../../../domain/menu.dart';

class MenuWidget extends StatelessWidget{

  //RekriaLogger logger = getIt<RekriaLogger>();
  List<Menu> menuSettings;


  MenuWidget({
    required this.menuSettings});

  @override
  Widget build(BuildContext context) {

    AppTheme appTheme = Environment().config.appTheme;

    Color sectionForegroundColor = appTheme.getPrimaryForegroundColor();

    MenuHelper menuHelper = MenuHelper(
        menuSettings: menuSettings,
        sectionIconColor: sectionForegroundColor);

    return
      Center(child:
      Padding(
      padding: EdgeInsets.symmetric(
          //vertical: 5,
          horizontal: 5),

      child: Container (
        //width:  (MediaQuery.of(context).size.width > 500)?500:null ,
        child: ListView(
          children: [
            _buildSection(menuHelper.section, appTheme.getPrimaryBackgroundColor(), sectionForegroundColor,context),
          ],
        ),
      )
    ));
  }


  Widget _buildSection(MenuSection menuSection, Color backColor, Color textColor, BuildContext context) {

    if( menuSection.items.isNotEmpty ){
      return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 0),
          child: Container (
            child:
            Column(
              children: [
                _buildSectionItems(context, menuSection.items, backColor, textColor)
              ],
            ),

          )

      );
    }else{
      return SizedBox.shrink();
    }

  }

  Widget _buildSectionItems(BuildContext context, List<MenuSectionItem> items, Color backColor, Color textColor) {

    List<Widget> widgets = List.empty(growable: true);

    for(var index=0; index< items.length; index=index+2){
      MenuSectionItem? item1 = (index<items.length)?items[index]:null;
      MenuSectionItem? item2 = (index+1<items.length)?items[index+1]:null;
      widgets.add( _buildSectionItemsRow(context, item1, item2, backColor, textColor) );
    }

    return Container(
      padding: EdgeInsets.only(top: 5,bottom: 5, left:20, right: 20),
      child: Column(children: widgets,)
    );

  }

  Widget _buildSectionItemsRow(BuildContext context, MenuSectionItem? item1, MenuSectionItem? item2, Color backColor, Color textColor ){

    return Row(
      children: [
        Expanded(
          flex: 4,
          child: _buildMenuSectionItem(context, item1, backColor, textColor),
        ),
        Expanded(
          flex: 4,
          child: _buildMenuSectionItem(context, item2, backColor, textColor),
        ),
      ],
    );

  }

  Widget _buildMenuSectionItem(BuildContext context, MenuSectionItem? item, Color backColor, Color textColor) {
    return MenuWidgetItem(item: item, backColor: backColor, textColor: textColor);
  }

}
