import 'package:flutter/material.dart';

class RouterService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {dynamic args}) {
    return navigatorKey.currentState.pushNamed(routeName, arguments: args);
  }

  Future<dynamic> navigateToAndReplace(String routeName, {dynamic args}) {
    return navigatorKey.currentState
        .pushReplacementNamed(routeName, arguments: args);
  }

  Future<dynamic> pushNamedAndRemoveUntil(String routeName, {dynamic args}) {
    return navigatorKey.currentState.pushNamedAndRemoveUntil(
        routeName, (Route<dynamic> route) => false,
        arguments: args);
  }

  pop() {
    navigatorKey.currentState.pop();
  }
}
