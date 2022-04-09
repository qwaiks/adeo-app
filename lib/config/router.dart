import 'package:adeo_app/constants/app_routes.dart';
import 'package:adeo_app/views/class_preference.screen.dart';
import 'package:adeo_app/views/level_preference.screen.dart';
import 'package:adeo_app/views/welcome.screen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case AppRoutes.welcomeRoute:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
    case AppRoutes.levelRoute:
      return MaterialPageRoute(
          builder: (context) => const LevelPreferenceScreen());
    case AppRoutes.classRoute:
      return MaterialPageRoute(
          builder: (context) => ClassPreferenceScreen(
                selectedLevel: settings.arguments ,
              ));
    default:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
  }
}
