import 'package:adeo_app/config/locator.dart';
import 'package:adeo_app/config/provider.dart';
import 'package:adeo_app/config/router.dart';
import 'package:adeo_app/constants/app_string.dart';
import 'package:adeo_app/services/router.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/app_routes.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppString.appName,
        theme: ThemeData(
          fontFamily: AppString.primaryFont,
          primarySwatch: Colors.green,
        ),
        onGenerateRoute: generateRoute,
        initialRoute: AppRoutes.welcomeRoute,
        navigatorKey: locator<RouterService>().navigatorKey,
      ),
    );
  }
}

