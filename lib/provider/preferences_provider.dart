import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/data/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;
 
  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyNewsPreferences();
  }


  bool _isDailyRestaurantActive = false;
  bool get isDailyRestaurantsActive => _isDailyRestaurantActive; 

  void _getDailyNewsPreferences() async {
    _isDailyRestaurantActive = await preferencesHelper.isDailyRestaurantsActive;
    notifyListeners();
  }
 
  void enableDailyNews(bool value) {
    preferencesHelper.setDailyRestaurants(value);
    _getDailyNewsPreferences();
  }
}