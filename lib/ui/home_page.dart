import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:submission1_restaurant_app/ui/restaurant_detail_page.dart';
import 'package:submission1_restaurant_app/ui/restaurant_favorite.dart';
import 'package:submission1_restaurant_app/ui/restaurant_list_page.dart';
import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/ui/restaurant_search.dart';
import 'package:submission1_restaurant_app/ui/restaurant_settings.dart';
import 'package:submission1_restaurant_app/utils/notification_helper.dart';
import '../widget/platform_widget.dart';


class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  static const String _headlineText = 'Restaurants';
  static const String _secondText = 'Search';
  static const String _thirdText = 'Favorite';
  static const String _fourthText = 'Settings';
  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<Widget> _listWidget = [
    RestaurantListPage(),
    const RestaurantSearchPage(),
    FavoritesPage(),
    RestaurantSettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: _headlineText,
    ),

    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: _secondText,
    ),

    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS
        ? CupertinoIcons.square_favorites
        : Icons.favorite),
      label: _thirdText,
  ),

    const BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: _fourthText,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: _bottomNavBarItems),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
    );
  }

    @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
        RestaurantDetailPage.routeName);
  }
  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }


}