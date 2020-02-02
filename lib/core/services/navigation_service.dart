import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  bool pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndNavigateTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .popAndPushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceTo(String routeName, {dynamic arguments}) {
    return _navigationKey.currentState
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  Future<dynamic> replaceWithoutAnimationTo(Widget page, {dynamic arguments}) {
    return _navigationKey.currentState.pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => page,
    ));
  }
}
