import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ATIcons{

  Widget get iconBack =>const Icon(Icons.arrow_back_ios);
  Widget get iconMenu =>const Icon(Icons.menu);
  Widget get iconClose =>const Icon(Icons.close);
  Widget get iconForward =>const Icon(Icons.arrow_forward_ios);
  Widget get iconRefresh =>const Icon(Icons.refresh);


  Widget get iconSettings =>const Icon(Icons.settings);

  Widget getIconCheckRounded({Color? color, double? size}) =>
      Icon(size: size,Icons.check, color:color??Environment().config.appTheme.getBodyForegroundColor());
  Widget get iconCheckRounded =>getIconCheckRounded(color: Colors.green, size: 200);

  Widget getIconQrCode(Color? color, double? size) =>
      Icon(size: size,Icons.qr_code, color:color??Environment().config.appTheme.getBodyForegroundColor());
  Widget get iconQrCode => getIconQrCode(null, 20);

  Widget getIconEdit(Color? color, double? size) =>
      Icon(size: size,Icons.edit, color:color??Environment().config.appTheme.getBodyForegroundColor());
  Widget get iconEdit => getIconEdit(null, 20);

  Widget getIconShare(Color? color, double? size) =>
      Icon(size: size,Icons.ios_share, color:color??Environment().config.appTheme.getBodyForegroundColor());
  Widget get iconShare => getIconShare(null, 20);

  Widget getIconHome(Color? color, double? size) => Icon(Icons.home, color:color, size: size);
  Widget get iconHome => getIconHome(null, 25);

  Widget getIconAccount(Color? color, double? size) => Icon(Icons.account_circle, color:color, size: size);
  Widget get iconAccount =>getIconAccount(null, 25);


  Widget getIconAdd(Color? color, double? size) => Icon(Icons.add, color:color, size: size);
  Widget get iconAdd =>getIconAdd(null, 25);

  Widget getIconAbout(Color? color, double? size) => Icon(Icons.ac_unit, color:color, size: size);
  Widget get iconAbout =>getIconAbout(null, 25);

  Widget getIconPrivacyPolicy(Color? color, double? size) => Icon(Icons.privacy_tip_outlined, color:color, size: size);
  Widget get iconPrivacyPolicy =>getIconPrivacyPolicy(null, 25);

  Widget getIconSignedOut(Color? color, double? size) =>  Icon(Icons.logout_outlined, color:color, size: size);
  Widget get iconSignedOut =>getIconSignedOut(null, 25);

  Widget inputTextIconUser({Color? color}){
    Color iconColor = color??Environment().config.appTheme.getPrimaryBackgroundColor();
    return _inputTextIcon( Icons.person_outline, iconColor);
  }

  Widget inputTextIconEmail({Color? color}){
    Color iconColor = color??Environment().config.appTheme.getPrimaryBackgroundColor();
    return _inputTextIcon( Icons.email, iconColor);
  }

  Widget inputTextIconPassword({Color? color}){
    Color iconColor = color??Environment().config.appTheme.getPrimaryBackgroundColor();
    return _inputTextIcon( Icons.key, iconColor);
  }

  Widget inputTextIconMobile({Color? color}){
    Color iconColor = color??Environment().config.appTheme.getPrimaryBackgroundColor();
    return _inputTextIcon( Icons.phone, iconColor);
  }

  Widget inputTextIconHashtag({Color? color}){
    Color iconColor = color??Environment().config.appTheme.getPrimaryBackgroundColor();
    return _inputTextIcon( Icons.numbers, iconColor);
  }

  Widget inputTextIconQrCode({Color? color}){
    Color iconColor = color??Environment().config.appTheme.getPrimaryBackgroundColor();
    return _inputTextIcon( Icons.qr_code, iconColor);
  }

  Widget inputTextIconPinCode({Color? color}){
    Color iconColor = color??Environment().config.appTheme.getPrimaryBackgroundColor();
    return _inputTextIcon( Icons.pin, iconColor);
  }

  Widget getIconRounded({Color? color, double? fontSize, required IconData iconData, double? rightPadding}) {
      return Center(
          child:Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100),
                ),
                border: Border.all(
                  width: 5,
                  color: color??Environment().config.appTheme.getPrimaryBackgroundColor(),
                  style: BorderStyle.solid,
                ),
              ),
              padding:  EdgeInsets.only(left: 12, right: rightPadding??15, top: 12, bottom: 12),
              child:
              Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[Icon( iconData, size: fontSize??40,color: color?? Environment().config.appTheme.getPrimaryBackgroundColor())],
              )
          ));
  }

  Widget getIconRoundedBackground({double? width, double? height, Color? color,Color? borderColor,Color? backColor, double? fontSize,  IconData? iconData, Widget? picture,double? rightPadding}) {
    return Container(
            width: width??45,
            height: height??45,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(100),
              ),
              color: backColor?? Colors.transparent,
              border: Border.all(
                width: 5,
                color: borderColor??backColor??color??Environment().config.appTheme.getPrimaryBackgroundColor(),
                style: BorderStyle.solid,
              ),
            ),
            padding:  const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            child:
            Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if(picture == null)Icon( iconData, size: fontSize??40,color: color?? Environment().config.appTheme.getPrimaryBackgroundColor()),
                if(picture != null)picture
                 ],
            )
        );
  }


  Widget _inputTextIcon(IconData iconData, Color color){
    return Padding(
        padding: EdgeInsets.all( 0),
        child: Icon(iconData, color:Environment().config.appTheme.getBodyForegroundColor()), // myIcon is a 48px-wide widget.
        );
    /*return Padding(
        padding: EdgeInsets.all( 0),
        child:Container(
          color: color,
          child: Icon(iconData, color:Environment().config.appTheme.getPrimaryForegroundColor()), // myIcon is a 48px-wide widget.
        ));*/
  }


  Widget getIconSanity(Color? color, double? size) =>  Image(
      color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      matchTextDirection: true,
      height: size,
      width: size,
      image:AssetImage("assets/images/menu_sanity.png")
  );
  Widget get iconSanity =>getIconSanity(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconSanityPlan(Color? color, double? size) =>  Image(
      color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      matchTextDirection: true,
      height: size,
      width: size,
      image:AssetImage("assets/images/menu_sanity-plan.png")
  );
  Widget get iconSanityPlan =>getIconSanityPlan(Environment().config.appTheme.getPrimaryBackgroundColor(),60);


  Widget getIconBull(Color? color, double? size) =>  Image(
      color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      matchTextDirection: true,
      height: size,
      width: size,
      image:AssetImage("assets/images/menu_bull.png")
  );
  Widget get iconBull =>getIconBull(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconFood(Color? color, double? size) =>  Image(
      //color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      matchTextDirection: true,
      height: size,
      width: size,
      image:AssetImage("assets/images/grass_2036685.png")
  );
  Widget get iconFood =>getIconFood(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconWater(Color? color, double? size) =>  Image(
      //color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      matchTextDirection: true,
      height: size,
      width: size,
      image:AssetImage("assets/images/watering_7634163.png")
  );
  Widget get iconWater =>getIconWater(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconAnimal(Color? color, double? size) =>  Image(
      //color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      matchTextDirection: true,
      height: size,
      width: size,
      image:AssetImage("assets/images/cow_1602197.png")
  );
  Widget get iconAnimal =>getIconAnimal(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconCow(Color? color, double? size) =>  Image(
      color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      matchTextDirection: true,
      height: size,
      width: size,
      image:AssetImage("assets/images/menu_cow.png")
  );
  Widget get iconCow =>getIconCow(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconCalendar(Color? color, double? size) =>  Image(
      color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      matchTextDirection: true,
      height: size,
      width: size,
      image:AssetImage("assets/images/menu_calendar.png")
  );
  Widget get iconCalendar =>getIconCalendar(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconRecria(Color? color, double? size) =>  Image(
      color: color??Environment().config.appTheme.getPrimaryForegroundColor(),
      matchTextDirection: true,
      height: size,
      width: size,
      image:AssetImage("assets/images/menu_recria.png")
  );
  Widget get iconRecria =>getIconRecria(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconByName(String icon, {Color? color, double? size}) {
    Widget widget = Icon(Icons.home, color: color,size: size);
    switch(icon){

      case "sanity":widget = getIconSanity(color, size); break;
      case "cow":widget = getIconCow(color, size); break;
      case "sanity-plan":widget = getIconSanityPlan(color, size); break;
      case "bull":widget = getIconBull(color, size); break;
      case "calendar":widget = getIconCalendar(color, size); break;
      case "recria":widget = getIconRecria(color, size); break;
      case "tracking":widget = getIconTrackng(color, size); break;
      case "select-company":widget = getIconSelectCompany(color, size); break;

      case "account":widget = getIconAccount(color, size); break;
      case "about-us":widget = getIconAbout(color, size); break;
      case "privacy-policy":widget = getIconPrivacyPolicy(color, size); break;
      case "home":widget = getIconHome(color, size); break;
      case "help":widget = getIconHelp(color, size); break;
    }

    return widget;
  }

  Widget getIconTrackng(Color? color, double? size) => Icon(Icons.route_outlined, color:color, size: size);
  Widget get iconTrackng =>getIconTrackng(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconSelectCompany(Color? color, double? size) => Icon(Icons.cached, color:color, size: size);
  Widget get iconSelectCompany =>getIconSelectCompany(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconNoInternet(Color? color, double? size) => Icon(Icons.wifi_off, color:color, size: size);
  Widget get iconNoInternet =>getIconNoInternet(Environment().config.appTheme.getPrimaryBackgroundColor(),60);

  Widget getIconNoLocation(Color? color, double? size) => Icon(Icons.location_disabled, color:color, size: size);
  Widget get iconNoLocation =>getIconNoLocation(Environment().config.appTheme.getPrimaryBackgroundColor(),60);


  Widget getIconHelp(Color? color, double? size) => Icon(Icons.help_outline, color:color, size: size);
  Widget get iconHelp =>getIconHelp(null,20);

  Widget getIconSupport(Color? color, double? size) => Icon(Icons.email_outlined, color:color, size: size);
  Widget get iconSupport =>getIconSupport(null,20);

}