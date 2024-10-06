
import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:flutter/material.dart';

class TrackAnimalItem extends StatelessWidget {

  final TrackAnimal trackAnimal;
  final Function(BuildContext context, TrackAnimal selected) onSelect;

  const TrackAnimalItem({
    Key? key,
    required this.trackAnimal,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget body = ListTile(
      trailing: Text("${trackAnimal.quantity??0}", style: TextStyle(fontSize: 18, color: Environment().config.appTheme.getTertiaryForegroundColor()) ,),
      title: Text(trackAnimal.typeDesc??"", style: TextStyle(color: Environment().config.appTheme.getTertiaryForegroundColor()),

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
            this.onSelect(context, this.trackAnimal);
          },
          child: body,
        )
      ),
      );
  }


}