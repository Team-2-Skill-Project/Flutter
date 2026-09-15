import 'dart:core';

import 'package:MatchIn/core/services/shared_preferences_service.dart';

class SplashLocalDataSource {
  SplashLocalDataSource({required this.sharedPreferencesService});

  final SharedPreferencesService sharedPreferencesService;
  
  bool getOnBoardingState() {
    return sharedPreferencesService.isOnBoardingViewed();
  }

  bool getLoggedInState() {
    return sharedPreferencesService.isLoggedIn();
  }
}
