
import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/utils/date_utils.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TrackListItem extends StatelessWidget {

  final Track track;
  final Function(BuildContext context, Track selectedTrack) onSelect;

  const TrackListItem({
    Key? key,
    required this.track,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget card = Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: SizedBox(
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: const Icon(Icons.account_circle),
          title: Text( track.paddockDesc??""),
          //title: _buildPercentage(context),
          subtitle: Text( ATDateUtils().format(track.datetime, pattern: "E dd/MM")),
          //trailing: const Icon(Icons.arrow_forward),
          trailing: _buildPercentage(context),
        ),
      ),
    );

    return GestureDetector(
      onTap: (){
        //this.onSelect(context, this.company);
      },
      child: card,
    );


  }

  Widget _buildPercentage(BuildContext context){
    return new Container(
      padding: EdgeInsets.all(0),
      child:
          new CircularPercentIndicator(
            radius: 25.0,
            lineWidth: 5.0,
            percent: 0.30,
            center: new Text("30%"),
            progressColor: Colors.orange,
          )

      );
  }
  Widget _buildPercentages(BuildContext context){
    return new Container(
      padding: EdgeInsets.all(15.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 4.0,
            percent: 0.30,
            center: new Text("30%"),
            progressColor: Colors.orange,
          ),
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          new CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 4.0,
            percent: 0.60,
            center: new Text("60%"),
            progressColor: Colors.yellow,
          ),
          new Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          new CircularPercentIndicator(
            radius: 30.0,
            lineWidth: 4.0,
            percent: 0.90,
            center: new Text("90%"),
            progressColor: Colors.green,
          )
        ],
      ),
    );
  }

}