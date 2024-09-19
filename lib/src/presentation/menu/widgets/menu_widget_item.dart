import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/model/menu_item.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_responsive_text.dart';


class MenuWidgetItem extends StatelessWidget{

  MenuSectionItem? item;
  Color backColor;
  Color textColor;

  MenuWidgetItem({required this.item, required this.backColor, required this.textColor});

  @override
  Widget build(BuildContext context) {

    Widget body= _buildMenuEnabled(context, item, backColor, textColor);

    return Padding(
        padding: EdgeInsets.all(5),
        child: body)
    ;

  }

  Widget _buildMenuEnabled(BuildContext context, MenuSectionItem? item, Color backColor, Color textColor) {
    if(item!=null)
      return
        GestureDetector(
              onTap: (){
                  NavHelper().navToPageLink(context, item.link, arguments: item.args);
              },
              child: buildMenu(context, item, backColor, textColor),
           );
    else
      return SizedBox.shrink();

  }

  Widget _buildMenuDisabled(BuildContext context, MenuSectionItem? item, Color backColor, Color textColor) {
    return buildMenu(context, item,  backColor.withOpacity(0.5), textColor.withOpacity(0.5));
  }

  Widget buildMenu(BuildContext context, MenuSectionItem? item, Color backColor, Color textColor) {
    if(item!=null)
      return
        Container(
                padding: EdgeInsets.symmetric(vertical: 20,horizontal: 5),
                decoration: BoxDecoration(
                  color: backColor,
                  //borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Column(
                  children: [
                    _buildIcon(item),
                    Divider(height: 10, color: Colors.transparent),
                    ATResponsiveText(item.title,
                      textAlign: TextAlign.center,
                      style: ATFonts().getMenuItem(textColor),)
                  ],
                ),
              );
    else
      return SizedBox.shrink();

  }


  Widget _buildIcon( MenuSectionItem item ){

    if(item.icon2!=null){
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [item.icon, VerticalDivider(width: 5, color: Colors.transparent), item.icon2??SizedBox.shrink()]);
    }else{
      return item.icon;
    }

  }
}
