import 'package:agro_tracking_flutter/src/domain/menu.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/model/menu_item.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/model/menu_section.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * Helps to build Main Menu
 */
class MenuHelper {

  late MenuSection section;

  Color sectionIconColor;
  double iconSize;

  List<Menu> menuSettings;

  MenuHelper(
      { required  this.menuSettings,
        required  this.sectionIconColor,
        this.iconSize=50}
      ){
    _buildMenu();
  }

  void _buildMenu() {

    List<MenuSectionItem> sectionItems = List.empty(growable: true);


    menuSettings.forEach((menu) {
      _addItem( list: sectionItems,
          code: menu.code,
          icon: ATIcons().getIconByName(menu.icon, color: sectionIconColor, size: iconSize),
          title: menu.label,
          link: menu.link,
      );

    });

    this.section = MenuSection(title: "MENU", items: sectionItems);

  }

  bool _isVisible(String menuCode){
    bool isVisible=true;

    this.menuSettings.forEach((menuSetting) {
      if(menuCode == menuSetting.code){
        isVisible = menuSetting.visible;
      }
    });

    return isVisible;
  }

  void _addItem(
      {
        required List<MenuSectionItem> list,
        required String code,
        required Widget icon,
        Widget? icon2,
        required String title,
        required String link,
        bool requireSelectedEvent=false,
        String args=""}) {

    if( _isVisible(code) ){
      list.add(
          MenuSectionItem(
              code:code,
              icon: icon,
              icon2: icon2,
              title: title,
              link: link,
              args: args) );
    }
  }
}