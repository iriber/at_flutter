
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_state.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FarmSubtitle extends StatelessWidget  {

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<FarmSelectBloc, FarmSelectState>(
        builder: (context, state) {
          Widget widget;

          if( state.hasCompanySelected() ){
            widget = _buildBody(context, state.selectedFarm);
          }else{
            widget = SizedBox.shrink();
          }
          return Container(
            child: widget,
            width: double.infinity,
          );
        });
  }

  Widget _buildBody(BuildContext context, Farm? company) {
    return Padding(
      padding: EdgeInsets.only(top: 15, left: 15),
      child: Text(
        company?.name??"",
        style: ATFonts().headline3,
        textAlign: TextAlign.left,
      ),
    );
  }


}