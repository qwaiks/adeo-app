import 'package:adeo_app/config/locator.dart';
import 'package:adeo_app/services/http.service.dart';
import 'package:adeo_app/services/router.service.dart';
import 'package:flutter/material.dart';

enum UiState { idle, loading, done, error }

class BaseProvider with ChangeNotifier {
  final router = locator<RouterService>();
  final http = locator<HttpService>();

  UiState uiState = UiState.idle;
  bool secondaryLoading = false;

  // Getters
  get isLoading => uiState == UiState.loading;

  get isDone => uiState == UiState.done;

  get hasError => uiState == UiState.error;

  // Functions
  void setUiState(UiState _uiState) {
    uiState = _uiState;
    notifyListeners();
  }

  void initProvider() {}

  void reset() {}
}
