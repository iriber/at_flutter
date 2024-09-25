import 'package:agro_tracking_flutter/src/config/enviroment.dart';
import 'package:agro_tracking_flutter/src/domain/animal_type.dart';
import 'package:agro_tracking_flutter/src/domain/app_theme.dart';
import 'package:agro_tracking_flutter/src/domain/track_animal.dart';
import 'package:agro_tracking_flutter/src/presentation/layouts/at_appbar_layout.dart';
import 'package:agro_tracking_flutter/src/presentation/nav/nav_helper.dart';
import 'package:agro_tracking_flutter/src/presentation/styles/at_fonts.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_animal_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_animal_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_animal_state.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_bloc.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_add_events.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/bloc/track_animal_form.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/animal/track_animal_category_tab.dart';
import 'package:agro_tracking_flutter/src/presentation/tracks/widgets/track_edit_breadcrumb.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_button.dart';
import 'package:agro_tracking_flutter/src/presentation/widgets/at_error_msg.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fiona_layout/src/presentation/layouts/ifiona_appbar_layout_page.dart';
import 'package:fiona_i18n/fiona_i18n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TrackAddAnimalCategoryPage extends StatelessWidget implements IFionaAppBarLayoutPage {

  late TrackAnimalCategoryTab categoryTab;

  TrackAddAnimalCategoryPage(BuildContext context, {Key? key}) : super(key: key) {
   //BlocProvider.of<TrackAddAnimalBloc>(context).add((const InitTrackAnimalAddRequested()));
   //DependencyManager().get<CompanySelectBloc>().add((const FetchAllCompaniesRequested()));
  }

  @override
  Widget build(BuildContext context) {

    return PopScope(

        child: ATAppBarLayout.likePopup(this, onClose: _onWillPop)
    );

  }

  Future<bool> _onWillPop(BuildContext context) async {
    ATErrorMessage.cleanMessages();

    //TODO preguntar si quiere irse y/ guardar los cambios

    return true;
  }


  SnackBar _buildSnackBar(msg){
    AppTheme appTheme = Environment().config.appTheme;
    return SnackBar(
      content: _buildMsg(msg),
      backgroundColor:  appTheme.getErrorBackgroundColor(),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2 ),
      elevation: 20,
      margin: EdgeInsets.only(
          right: 20,
          left: 20,
          bottom: 250//(MediaQuery.of(context).size.height/2)
      ),
    );
  }
  Widget _buildMsg(msg){
    AppTheme appTheme = Environment().config.appTheme;
    return
      Container(
        color: appTheme.getErrorBackgroundColor(),
        padding: const EdgeInsets.fromLTRB(40,10,40,10),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: ATFonts().errorText),
      );
  }
  @override
  Widget buildBody(BuildContext context) {

    return BlocConsumer<TrackAddAnimalBloc, TrackAddAnimalState>(
        listener: (context, state) {
          switch(state.status){
            case TrackAddAnimalStatus.success:{
              //TODO cierro y me voy al padre, tengo q avisar que agregué algo
              TrackAnimal? trackAnimal = state.form?.buildTrackAnimal()??TrackAnimal.empty();
              BlocProvider.of<TrackAddBloc>(context).add(TrackLivestockTrackAnimalRequested(trackAnimal));
              NavHelper().back(context);
            }break;
          case TrackAddAnimalStatus.failure:{
              //TODO show message.???
            Environment().rootScaffoldMessengerKey.currentState?.showSnackBar(_buildSnackBar(state.message??"algo"));
            }break;
          //TODO next step.
            default: break;
          }
        },
        builder: (context, state) {

          Widget bodyWidget ;
          switch(state.status){
            case TrackAddAnimalStatus.initial:{
              bodyWidget = _buildPage(context, state);
            }break;
            case TrackAddAnimalStatus.sending:{
              bodyWidget = _buildPage(context, state);
            }break;
            case TrackAddAnimalStatus.failure:{
              bodyWidget = _buildPage(context, state);
            }break;
            default:{
              bodyWidget = const Center();
            }
          }
          //_setTitle(context,state);
          return Container(
            //color: Environment().config.appTheme.getBodyBackgroundColor() ,
              child: bodyWidget
          );
        }
    );
  }

  Widget _buildPage(BuildContext context, TrackAddAnimalState state) {
    return Column(
        children: [
          Expanded(child: _buildBreadcrumb(context, state ), flex: 1,),
          Expanded(child: buildTabs(context, state),flex: 8,),
          Expanded(child: _buildFooter(context, state ), flex: 1,),
        ]);
  }

  Widget buildTabs(BuildContext context, TrackAddAnimalState state) {

    categoryTab = TrackAnimalCategoryTab(state);

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox.shrink(),
          toolbarHeight: 0,
          leading: SizedBox.shrink(),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: ClipRRect(
              //borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                height: 40,
                //margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  //borderRadius: const BorderRadius.all(Radius.circular(1)),
                  color: Colors.green.shade100,
                ),
                child:  TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors.transparent,
                  indicator: BoxDecoration(
                    color: Colors.green,
                    //borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.black54,
                  tabs: [
                    TabItem(title: Fionai18n.message("track.animal.category")),
                    TabItem(title: Fionai18n.message("track.animal.corporalCapacity")),
                    TabItem(title: Fionai18n.message("track.animal.sanityPlan")),
                    TabItem(title: Fionai18n.message("track.animal.media")),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: categoryTab),
            Center(child: Text(Fionai18n.message("track.animal.corporalCapacity"))),
            Center(child: Text(Fionai18n.message("track.animal.sanityPlan"))),
            Center(child: Text(Fionai18n.message("track.animal.media"))),
          ],
        ),
      ),
    );
  }

  String getTitle(){
    return Fionai18n.message("tracks.add.animal.category.title");
  }

  Widget _buildFooter(BuildContext context, TrackAddAnimalState state) {

    bool isSending = (state.status==TrackAddAnimalStatus.sending);

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 80),
        child: ATPrimaryButton(
            label: (isSending?Fionai18n.message("sending"):Fionai18n.message("save")),
            onTap:(BuildContext context){
              if(!isSending){
                doSave(context, state);
              }
            }
        )
    );

  }

  TrackEditBreadcrumb _buildBreadcrumb(BuildContext context, TrackAddAnimalState state) {

    List<TrackEditBreadcrumbItem> items = List.empty(growable: true);

    items.add(TrackEditBreadcrumbItem("Potrero 1B"));
    items.add(TrackEditBreadcrumbItem("Ganadería"));
    items.add(TrackEditBreadcrumbItem("Animal"));
    items.add(TrackEditBreadcrumbItem("Categoria"));
    return TrackEditBreadcrumb(breadcrumbs: items);

  }

  void doSave(BuildContext context, TrackAddAnimalState state){

    TrackAnimalForm form = state.form??TrackAnimalForm.empty();

    categoryTab.fillForm(form);

    AnimalType? animalType = form.getAnimalTypeValue();
    debugPrint("Animal type: ${animalType?.type?.label}" );

    BlocProvider.of<TrackAddAnimalBloc>(context).add(( TrackAddAnimalRequested(form)));


  }
}

class TabItem extends StatelessWidget {
  final String title;

  const TabItem({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return Tab(child: Text(title),);
  }
}