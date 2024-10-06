import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/media/widgets/take_picture.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_loading_spinner.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:agro_tracking_flutter/src/domain/menu.dart';
import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_events.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/bloc/menu_state.dart';
import 'package:agro_tracking_flutter/src/presentation/menu/widgets/menu_widget.dart';

import 'package:fiona_layout/src/presentation/layouts/ifiona_appbar_layout_page.dart';

class MediaPage extends StatelessWidget implements IFionaAppBarLayoutPage {


  @override
  Widget build(BuildContext context) {
    return ATAppBarLayout(this);//, menuButton: true,);
  }

  @override
  Widget buildBody(BuildContext context) {
    return _buildPage(context);
  }

  String getTitle(){
    return "Media";
  }

  Widget _buildPage(BuildContext context) {
    return Container(
      child: _buildTakePicture(context),
    );
  }

  Future<CameraDescription> getCamera() async {

    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final CameraDescription firstCamera = cameras.first;
    return firstCamera;
  }

  Widget _buildTakePicture(BuildContext context){
    return FutureBuilder<CameraDescription>(
      future: getCamera(), //
      builder: (BuildContext context, AsyncSnapshot<CameraDescription> snapshot) {
        Widget result ;
        if (snapshot.hasData ) {
          result =  TakePicture( camera:snapshot.requireData, onTaken: onTaken,);
        } else if (snapshot.hasError) {
          result = Text("error");// SizedBox.shrink();
        } else {
          result =  ATLoadingSpinner();
        }
        return result;
      },

    );
  }

  Future<void> onTaken(String imagePath) async{
    debugPrint("FOTO: ${imagePath}");
  }
}
