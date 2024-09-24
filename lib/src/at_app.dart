import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/farm_select_page.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/login/login_page.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/menu_page.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/app_title/bloc/app_title_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/splashscreen.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_theme_data.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_animal_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/tracks_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/track_add_animal_page.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/track_add_page.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/tracks_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:page_transition/page_transition.dart';
import 'package:fiona_logger/src/log/fiona_logger.dart';

import 'package:go_router/go_router.dart';


class ATApp extends StatefulWidget {

  const ATApp({Key? key}) : super(key: key);

  @override
  _ATAppState createState() => _ATAppState();


}

enum AppStatus { initial, loading, successLocal, successSync, failure }

class _ATAppState extends State<ATApp> {
  FionaLogger? logger = DependencyManager().get<FionaLogger>();

  AppTheme appTheme = Environment().config.appTheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [
        BlocProvider<AppTitleBloc>(
          create: (context) => AppTitleBloc(),
        ),
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<MenuBloc>(
          create: (context) => MenuBloc(),
        ),
        BlocProvider<FarmSelectBloc>(
          create: (context) => FarmSelectBloc(),
        ),
        BlocProvider<TracksBloc>(
          create: (context) => TracksBloc(),
        ),
        BlocProvider<TrackAddBloc>(
          create: (context) => TrackAddBloc(),
        ),
        BlocProvider<TrackAddAnimalBloc>(
          create: (context) => TrackAddAnimalBloc(),
        ),
      ],
      child: _buildMaterialApp(context),
    );
  }

  Widget _buildMaterialApp(BuildContext context) {

    final _router = GoRouter(
        initialLocation: '/home',
      routes:[
        GoRoute(
            path: "/",
            pageBuilder: (context, state) {
              return customTransition(context, state, LoginPage());
            }
        ),
        GoRoute(
            path: PagesConfig.loginLink,
            pageBuilder: (context, state) {
              return customTransition(context, state,  LoginPage());
            }
        ),
        GoRoute(
          path: PagesConfig.homeLink,
          pageBuilder: (context, state) {
            return customTransition(context, state, MenuPage());
          },
          routes: [
        GoRoute(
              path: "tracking",// PagesConfig.trackingLink,
              /*
              builder: (context, state) {
                return TracksPage(context);
              },*/
              pageBuilder: (context, state) {
                return customTransition(context, state, TracksPage(context));
              },
              routes: [
                GoRoute(
                  path:  "add",//PagesConfig.trackingAddLink,
                  pageBuilder: (context, state) {
                    return customTransition(context, state, TrackAddPage(context));
                  },
                    routes: [
                      GoRoute(
                        path:  "animal-add",//PagesConfig.trackingAddLink,
                        pageBuilder: (context, state) {
                          return customTransition(context, state, TrackAddAnimalCategoryPage(context));
                        },
                      ),
                    ]
                ),
              ],
            ),
          ],
          /*redirect: (context,state){
            //TODO check if the user is logged, else return "signin"
          }*/
        ),
        /*
        GoRoute(
          path: PagesConfig.trackingAnimalAddLink,
          builder: (context, state) {
            return TrackAddAnimalCategoryPage(context);
          },
        ),*/

        GoRoute(
          path: PagesConfig.selectFarmLink,
          builder: (context, state) {
             return FarmSelectPage(context);
            },
        ),
/*        GoRoute(
          path: PagesConfig.trackingLink,
          builder: (context, state) {
            return TracksPage(context);
          },
        ),
        GoRoute(
          path: PagesConfig.trackingAddLink,
          builder: (context, state) {
            return TrackAddPage(context);
          },
        ),*/
/*        GoRoute(
          path: PagesConfig.bullLink,
          builder: (context, state){
            return DependencyManager().getWithParam<EntityListPage<BullType>,BuildContext>(context);
          },
        ),
        GoRoute(
          path: PagesConfig.bullTypeAddLink,
          builder: (context, state){
            return DependencyManager().getWithParam<EntityAddPage<BullType>,BuildContext>(context);
          },
        )
*/
      ]
    );

    return MaterialApp.router(
      scaffoldMessengerKey: Environment().rootScaffoldMessengerKey,
      theme: ATThemeData().buildTheme(appTheme),
      debugShowCheckedModeBanner: false,
      routerDelegate: _router.routerDelegate,
      routeInformationParser: _router.routeInformationParser,
      routeInformationProvider: _router.routeInformationProvider,
    );
  }

  void updateAppTheme(AppTheme appTheme) {
    this.appTheme = appTheme;
    Environment().config.appTheme = appTheme;
  }

  PageTransition createTransition(BuildContext context, Widget page) {
    return PageTransition(
        type: PageTransitionType.bottomToTop,
        child: page,
        inheritTheme: true,
        ctx: context);
  }
  CustomTransitionPage customTransition(context, state, Widget child){
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Change the opacity of the screen using a Curve based on the the animation's
        // value
        return FadeTransition(
          opacity:
          CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },
    );
  }

  /*
  * transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Change the opacity of the screen using a Curve based on the the animation's
        // value
        return FadeTransition(
          opacity:
              CurveTween(curve: Curves.easeInOutCirc).animate(animation),
          child: child,
        );
      },*/
}
