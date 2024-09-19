import 'package:agro_tracking_flutter/src/presentation/menu/model/menu_item.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/widgets/menu_widget_item.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_styles.dart';
import 'package:flutter/material.dart';

class RigthDrawerMenuItem extends MenuWidgetItem{

  RigthDrawerMenuItem({required super.item, required super.backColor, required super.textColor});

  Widget buildMenu(BuildContext context, MenuSectionItem? item, Color backColor, Color textColor) {
    return ListTile(
      iconColor: backColor,
      leading: item?.icon,
      title: Text(item?.title??"", style: ATSideMenuStyles.getTextMenuItem(color:textColor)),
    );
  }
}
