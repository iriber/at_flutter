
import 'package:agro_tracking_flutter/src/domain/track.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_list_item.dart';
import 'package:agro_tracking_flutter/src/utils/date_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class TrackList extends StatelessWidget {

  List<Track> tracks;

  TrackList(this.tracks,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return _createGroupedListView() ;


    return CupertinoScrollbar(

      child: Column(

        children: [
          for (final track in tracks)
            TrackListItem(
              track: track,
              onSelect: (context, track) {
                //BlocProvider.of<FarmSelectBloc>(context).add((SelectFarmRequested(company)));
                //DependencyManager().get<CompanySelectBloc>().add(SelectCompanyRequested(company));

              },
            ),
        ],
      ),
    );
  }


  _createGroupedListView() {
    return GroupedListView<Track, String>(
      elements: tracks,
      groupBy: (element) => ATDateUtils().format(element.datetime, pattern: "MM yyyy"),
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) => (item1.datetime).compareTo(item2.datetime),
      order: GroupedListOrder.ASC,
      useStickyGroupSeparators: true,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          ATDateUtils().formatStrDate(value, inputPattern: "MM yyyy", outputPattern: "MMMM yyyy"),
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      itemBuilder: (c, element) {
        return TrackListItem(track: element,   onSelect: (context, track) {
          //BlocProvider.of<FarmSelectBloc>(context).add((SelectFarmRequested(company)));
          //DependencyManager().get<CompanySelectBloc>().add(SelectCompanyRequested(company));
          NavHelper().navToTrackingAdd(context,track: track);
        });
      },
    );
  }
}
