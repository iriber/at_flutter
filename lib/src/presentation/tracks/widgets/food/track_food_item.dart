
import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/track_food.dart';
import 'package:flutter/material.dart';

class TrackFoodItem extends StatelessWidget {

  final TrackFood trackFood;
  final Function(BuildContext context, TrackFood selected) onSelect;

  const TrackFoodItem({
    Key? key,
    required this.trackFood,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget body = ListTile(
      trailing: Text("${trackFood.hectares??trackFood.growUp}"),
      title: Text(trackFood.lotDesc??"", style: TextStyle(color: Environment().config.appTheme.getTertiaryForegroundColor()),
      ),
    );


    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          color: Environment().config.appTheme.getTertiaryBackgroundColor(),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        elevation: 5,
        //color: Colors.cyan,
        child:
        GestureDetector(
          onTap: (){
            this.onSelect(context, this.trackFood);
          },
          child: body,
        )
      ),
      );
  }


}