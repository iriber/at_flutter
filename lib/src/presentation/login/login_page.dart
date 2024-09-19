import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/user.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_events.dart';
import 'package:agro_tracking_flutter/src/presentation/layouts/at_login_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_events.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_state.dart';
import 'package:agro_tracking_flutter/src/presentation/login/widgets/login.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_error_msg.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_loading_spinner.dart';
import 'package:agro_tracking_flutter/src/utils/shared_pref_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fiona_layout/src/presentation/layouts/ifiona_layout_page.dart';

class LoginPage extends StatelessWidget implements IFionaLayoutPage {

  LoginPage({BuildContext? context, Key? key}) : super(key: key){
    if(context!=null){
      BlocProvider.of<LoginBloc>(context).add(CheckUserLoggedRequested());
    }

  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
        child: ATLoginLayout(this)
    );
  }

  @override
  Widget buildBody(BuildContext context) {

    return BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          switch(state.status){
            case LoginStatus.companyAlreadySelected:{
              BlocProvider.of<FarmSelectBloc>(context).add(SelectFarmRequested(state.company??Farm.empty()));
              NavHelper().navToHome(context);
            }break;
            case LoginStatus.alreadyLogged:{
              NavHelper().navToPageLink(context, PagesConfig.selectFarmLink);
            }break;
            case LoginStatus.success:{
              NavHelper().navToPageLink(context, PagesConfig.selectFarmLink);
            }break;
            default: break;
          }
        },
       builder: (context, state) {

          Widget bodyWidget ;
          switch(state.status){
            case LoginStatus.initial:{
              bodyWidget = _buildLoginForm(context, state);
            }break;
            case LoginStatus.loading:{
              bodyWidget = _buildLoading(context, state);
            }break;
            case LoginStatus.sending:{
              bodyWidget = _buildLoginForm(context, state);
            }break;
            case LoginStatus.failure:{
              bodyWidget = _buildFailure(context, state);
            }break;
           case LoginStatus.accountLocked:{
              BlocProvider.of<LoginBloc>(context).add(LogoutRequested());
              bodyWidget = const Center();
            }break;
            case LoginStatus.connectivityFailure:{
              bodyWidget = _buildConnectivityFailure(context, state);
            }break;
            default:{
              //goHome(context);//TODO esto acá no va, pero si no lo pongo cuando hago hot reload me caga, ver por qué pasa esto
              bodyWidget = const Center();
            }
          }
          return Container(
              //color: Environment().config.appTheme.getBodyBackgroundColor() ,
              child: bodyWidget
          );
        }
    );
  }


  Future<void> goHome(BuildContext context) async{

      //check if there is a company selected
      Farm companySelected = await SharedPrefUtils().getSelectedFarm();

      if(companySelected!=null && companySelected.id>0){
        NavHelper().navToHome(context);
      }else{
        //go to select a company.
        NavHelper().navToPageLink(context, PagesConfig.selectFarmLink);
      }



  }

  Widget _buildLoading(BuildContext context, LoginState state){

    return
      Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: ATLoadingSpinner()

      );

  }

  Widget _buildFailure(BuildContext context, LoginState state){

    return Login(state);
  }

  Widget _buildConnectivityFailure(BuildContext context, LoginState state){
    return SizedBox.shrink();// FunPassNoConnection();
  }

  Widget _buildLoginForm(BuildContext context, LoginState state){
    return Login(state);
  }


}
