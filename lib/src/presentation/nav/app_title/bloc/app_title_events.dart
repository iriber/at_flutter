
abstract class AppTitleEvent {
  const AppTitleEvent();

}

class TitleChangeRequested extends AppTitleEvent {
  final String title;
  final String? subtitle;
  TitleChangeRequested(this.title, {this.subtitle});
}
class DefaultTitleRequested extends AppTitleEvent {
  DefaultTitleRequested();
}
