import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:submission1_restaurant_app/data/api/api_service.dart';
import 'package:submission1_restaurant_app/data/database/database_helper.dart';
import 'package:submission1_restaurant_app/data/preferences/preferences_helper.dart';
import 'package:submission1_restaurant_app/provider/database_provider.dart';
import 'package:submission1_restaurant_app/provider/preferences_provider.dart';
import 'package:submission1_restaurant_app/provider/restaurant_provider.dart';
import 'package:submission1_restaurant_app/provider/restaurant_search_provider.dart';
import 'package:submission1_restaurant_app/provider/scheduling_provider.dart';
import 'package:submission1_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission1_restaurant_app/ui/home_page.dart';
import 'package:submission1_restaurant_app/ui/restaurant_list_page.dart';
import 'package:submission1_restaurant_app/ui/restaurant_search.dart';
import 'package:submission1_restaurant_app/ui/restaurant_settings.dart';
import 'package:submission1_restaurant_app/utils/background_service.dart';
import 'package:submission1_restaurant_app/utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        ),
        ChangeNotifierProvider<RestaurantProvider>(
        create: (_) => RestaurantProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider<SearchRestaurantProvider>(
          create: (_) => SearchRestaurantProvider(apiService: ApiService(), query: ''),
          ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner : false,
          title: 'CDXrestaurant',
          initialRoute: HomePage.routeName,
          routes: {
            HomePage.routeName: (context) => HomePage(),
            RestaurantListPage.routeName: (context) => RestaurantListPage(),
            RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurantdetail: ModalRoute.of(context)!.settings.arguments as String
            ),
            RestaurantSearchPage.routeName: (context) => const RestaurantSearchPage(),
            RestaurantSettingsPage.routeName: (context) => RestaurantSettingsPage(),
            
          },
        );
        },
      ),
    );
  }
}