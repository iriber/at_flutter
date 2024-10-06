import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class NavHelper{

  Future<void> openExternalBrowser(url)async{

      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri,mode: LaunchMode.externalApplication);
      } else {

      }

  }

  void navToHome(BuildContext context){
    context.go(PagesConfig.homeLink);
  }

  void navToLogin(BuildContext context){
    context.go(PagesConfig.loginLink);
  }

  void navToRegistration(BuildContext context){
    context.go(PagesConfig.registrationLink);
  }

  void navToForgotPassword(BuildContext context){
    context.go(PagesConfig.forgotPasswordLink);
  }

  void navToComingSoon(BuildContext context){
    navToPageLink(context, PagesConfig.comingSoonLink);

  }

  void navToPageLink(BuildContext context, String pageLink, {arguments=null}){
    context.go(pageLink);
  }

  void closeOrNavToLink(BuildContext context, String pageLink, {arguments=""}) {
    if(context.canPop()){
      context.pop();
    }else{
      this.navToPageLink(context, pageLink, arguments: arguments);
    }
  }

  void back(BuildContext context) async {

    if( context.canPop() )
      context.pop();
  }

  void popMe(BuildContext context) async {

    if( context.canPop() )
      context.pop();
  }

  void navToTrackingAdd(BuildContext context, {Track? track}){
    context.go(PagesConfig.trackingAddLink, extra:  track);
  }
}


