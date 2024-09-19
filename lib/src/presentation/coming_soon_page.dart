import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_error_msg.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fiona_layout/src/presentation/layouts/ifiona_appbar_layout_page.dart';

class ComingSoonPage extends StatelessWidget implements IFionaAppBarLayoutPage {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop:(){
          return _onWillPop(context);
        },
        child: ATAppBarLayout.likePopup(this, onClose: _onWillPop)
    );
  }

  Future<bool> _onWillPop(BuildContext context) async {
    ATErrorMessage.cleanMessages();
    return true;
  }

  @override
  Widget buildBody(BuildContext context) {
    return Container(
      child: Center(child:
      Padding(
          padding: EdgeInsets.symmetric(
            //vertical: 5,
              horizontal: 5),
          child: Container (
            child: ListView(
              children: [
                Text("Content in progress"),
              ],
            ),
          )
      )),
    );
  }

  String getTitle(){
    return "Coming Soon";
  }


}
