import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:shimmer/shimmer.dart';


class  ATLoadingList extends StatelessWidget{

  int itemCount;
  double itemHeight;
  Color itemColor;
  ATLoadingList({this.itemCount=3, this.itemHeight=40, this.itemColor=Colors.white});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: itemCount, // Adjust the count based on your needs
        itemBuilder: (context, index) {
          return ListTile(
            title: Container(
              height: itemHeight,
              //width: 200,
              color: itemColor,
            ),
          );
        },
      ),
    );
  }
}