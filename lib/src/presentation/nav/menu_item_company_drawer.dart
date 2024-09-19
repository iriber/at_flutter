

import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_state.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuItemCompanyDrawer extends StatelessWidget{

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
          );
        });

  }

  Widget _buildBody(BuildContext context, Farm? company){

    String companyDesc =company?.name??"";
    Widget body = Padding(padding: EdgeInsets.only(left: 10), child: Text(companyDesc, style: ATFonts().menuSettingsSubtitle));
    return body;

  }
}