import 'package:adeo_app/constants/app_routes.dart';
import 'package:adeo_app/views/welcome.screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.welcomeRoute:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
    default :
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
  }
}