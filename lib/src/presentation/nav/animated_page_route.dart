import 'package:flutter/material.dart';

class AnimatedPageRoute extends MaterialPageRoute {
  Widget page;

  AnimatedPageRoute(this.page)
      : super(builder: (BuildContext context) => page);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return page;
  }
}