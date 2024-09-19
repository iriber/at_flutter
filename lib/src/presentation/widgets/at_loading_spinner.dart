import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class  ATLoadingSpinner extends StatelessWidget{

  bool visible;
  double  height;
  double width;
  bool darkBackground;
  ATLoadingSpinner({this.visible=true,this.height=64, this.width=64, this.darkBackground=false});

  @override
  Widget build(BuildContext context) {
      return Visibility(
              visible: visible,
              child: Align(
                alignment: Alignment.center,
                child:
                LoadingAnimationWidget.hexagonDots(
                  color: this.darkBackground ? Colors.white : Colors.black,
                  size: height,
                ),
                )
            );
  }
}