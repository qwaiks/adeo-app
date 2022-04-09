
import 'package:adeo_app/services/http.service.dart';
import 'package:adeo_app/services/router.service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<RouterService>(RouterService());
  locator.registerSingleton<HttpService>(HttpService());
}


