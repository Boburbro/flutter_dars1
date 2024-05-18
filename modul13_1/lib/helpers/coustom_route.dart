import 'package:flutter/material.dart';

class CustomRoute extends PageRouteBuilder {
  final Widget page;

  CustomRoute({required this.page})
      : super(pageBuilder: (context, animation, secondaryAnimation) => page);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(
      alignment: Alignment.bottomCenter,
      scale: animation,
      child: child,
    );
  }
}

class CustomTransitionBuilder extends PageTransitionsBuilder {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      alignment: Alignment.bottomCenter,
      scale: animation,
      child: child,
    );
  }
}
