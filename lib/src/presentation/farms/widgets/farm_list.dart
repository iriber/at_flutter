import 'package:agro_tracking_flutter/src/dependency_manager.dart';
import 'package:agro_tracking_flutter/src/domain/farm.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/bloc/farm_select_events.dart';
import 'package:agro_tracking_flutter/src/presentation/farms/widgets/farm_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FarmList extends StatelessWidget {

  List<Farm> companies;

  FarmList(this.companies,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CupertinoScrollbar(

      child: Column(

        children: [
          for (final company in companies)
            FarmItem(
              company: company,
              onSelect: (context, company) {
                BlocProvider.of<FarmSelectBloc>(context).add((SelectFarmRequested(company)));
                //DependencyManager().get<CompanySelectBloc>().add(SelectCompanyRequested(company));

              },
            ),
        ],
      ),
    );
  }

}
