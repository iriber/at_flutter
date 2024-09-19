import 'package:agro_tracking_flutter/src/config/pages_config.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_events.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_form.dart';
import 'package:agro_tracking_flutter/src/presentation/login/bloc/login_state.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_icons.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_button.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_checkbox.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_error_msg.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fiona_i18n/fiona_i18n.dart';

class Login extends StatelessWidget{

  bool rememberMe = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LoginState loginState;

  Login(this.loginState) {
    nameController.text = this.loginState.form?.getEmail().value?? "";
    passwordController.text = this.loginState.form?.getPassword().value ?? "";
  }

  @override
  Widget build(BuildContext context) {
    bool isSending = (this.loginState.status==LoginStatus.sending);

    List<Widget> widgets = List.empty(growable: true);

    if (loginState.status == LoginStatus.failure) {
      widgets.add(ATErrorMessage(errorMsg: loginState.form?.getErrorLogin()?? ""));
    }

    widgets.add(Container(
      padding: const EdgeInsets.all(10),
      child: ATTextField(
        inputType: TextInputType.emailAddress,
        controller: nameController,
        enabled: (!isSending),
        label: Fionai18n.message("email"),
        error: loginState.form?.getEmail().errorMessage,
        prefixIcon: ATIcons().inputTextIconEmail(),
      ),
    ));

    widgets.add(Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ATTextField(
        controller: passwordController,
        label: Fionai18n.message("password"),
        enabled: (!isSending),
        error: loginState.form?.getPassword().errorMessage,
        prefixIcon: ATIcons().inputTextIconPassword(),
        hideText: true,
      ),
    ));

    widgets.add(Container(
      padding: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: Row(
        children: [
          ATCheckbox(callback: (value) {
            rememberMe = value;

          }),
          Text(style: ATFonts().loginText, Fionai18n.message("login.rememberMe"),),
          Spacer(),
          Stack(

            children: [
              TextButton(
                onPressed: () {
                  if(!isSending){
                    NavHelper().closeOrNavToLink(context, PagesConfig.forgotPasswordLink);
                  }
                },
                child: Text(
                  style: ATFonts().loginLinkText,
                    Fionai18n.message("login.forgotPassword"),
                ),
              )
            ],
          )
        ],
      ),
    ));

    widgets.add(
        Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 80),
            child: ATPrimaryButton(
                label: (isSending?Fionai18n.message("sending"):Fionai18n.message("login")),
                onTap:(BuildContext context){
                  if(!isSending){
                    doLogin(context);
                  }
                }
            )
        )
    );

    if(!isSending){

      widgets.add(
          Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 80),
              child: ATSecondaryBorderedButton(
                  label: Fionai18n.message("register"),
                  onTap:(BuildContext context){
                    if(!isSending){
                      //NavHelper().closeOrNavToLink(context, PagesConfig.registrationLink);
                    }
                  }
              )
          )
      );
    }


    return Container(

        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: widgets,
              ),
            )
          ],
        ));
  }


  void doLogin(BuildContext context) {
    String email =   nameController.text;
    String password = passwordController.text;

    LoginForm form = this.loginState.form??LoginForm.empty();

    form.getEmail().value = email;
    form.getPassword().value = password;

    BlocProvider.of<LoginBloc>(context).add(LoginRequested(form));

  }


}
