
import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/domain/menu.dart';
import 'package:agro_tracking_flutter/src/domain/repositories/menu_repository.dart';

class MenuInMemory implements MenuRepository{

  @override
  Future<List<Menu>> getMainMenu() async{


    List<Menu> menus = List.empty(growable: true);


    menus.add(
        Menu(0,
            code:PagesConfig.trackingMenuCode,
            icon: "tracking",
            label: "Recorridas",
            link: PagesConfig.trackingLink));

    menus.add(
        Menu(1,
            code:PagesConfig.sanityMenuCode,
            icon: "sanity",
            label: "Sanidad",
            link: PagesConfig.sanityLink));
/*
    menus.add(
        Menu(2,
            code:PagesConfig.cowMenuCode,
            icon: "cow",
            label: "Vacas",
            link: PagesConfig.cowLink));*/
/*
    menus.add(
        Menu(3,
            code:PagesConfig.sanityPlanMenuCode,
            icon: "sanity-plan",
            label: "Plan Sanitario",
            link: PagesConfig.sanityPlanLink));

    menus.add(
        Menu(4,
            code:PagesConfig.bullMenuCode,
            icon: "bull",
            label: "Toros",
            link: PagesConfig.bullLink));*/

    menus.add(
        Menu(5,
            code:PagesConfig.calendarMenuCode,
            icon: "calendar",
            label: "Agenda",
            link: PagesConfig.calendarLink));

    menus.add(
        Menu(6,
            code:PagesConfig.recriaMenuCode,
            icon: "recria",
            label: "Recría",
            link: PagesConfig.recriaLink));

    return menus;

  }

  @override
  Future<List<Menu>> getSidebarMenu() async{

    List<Menu> menus = List.empty(growable: true);


    menus.add(
        Menu(2,
            code:PagesConfig.aboutUsMenuCode,
            icon: "about-us",
            label: "Nosotros",
            link: PagesConfig.aboutUsLink));

    menus.add(
        Menu(3,
            code:PagesConfig.helpMenuCode,
            icon: "help",
            label: "Ayuda",
            link: PagesConfig.helpLink));


    return menus;

  }

}