import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;
 
  PreferencesHelper({required this.sharedPreferences});

  static const DAILY_RESTAURANTS = 'DAILY_RESTAURANTS';

    Future<bool> get isDailyRestaurantsActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_RESTAURANTS) ?? false;
  }
 
  void setDailyRestaurants(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_RESTAURANTS, value);
  }
}