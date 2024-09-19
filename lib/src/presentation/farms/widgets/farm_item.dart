
import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:flutter/material.dart';

class FarmItem extends StatelessWidget {

  final Farm company;
  final Function(BuildContext context, Farm selectedCompany) onSelect;

  const FarmItem({
    Key? key,
    required this.company,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget body = ListTile(
      title: Text(company.name, style: TextStyle(color: Environment().config.appTheme.getTertiaryForegroundColor()),
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
            this.onSelect(context, this.company);
          },
          child: body,
        )
      ),
      );
  }


}