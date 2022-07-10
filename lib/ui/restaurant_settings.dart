import 'dart:io';
import 'package:submission1_restaurant_app/provider/preferences_provider.dart';
import 'package:submission1_restaurant_app/provider/scheduling_provider.dart';
import 'package:submission1_restaurant_app/widget/custom_dialog.dart';
import 'package:submission1_restaurant_app/widget/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantSettingsPage extends StatelessWidget {
  static const routeName = '/restaurant_settings_page';
  static const String settingsTitle = 'Settings';

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(settingsTitle),
        backgroundColor: Colors.green,
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(settingsTitle),
      ),
      child: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
      return ListView(
        children: [
          Material(
            child: ListTile(
              title: const Text('Dark Theme'),
              trailing: Switch.adaptive(
                value: false,
                onChanged: (value) => customDialog(context),
              ),
            ),
          ),
           Material(
            child: ListTile(
              title: const Text('Scheduling Restaurant'),
              trailing: Consumer<SchedulingProvider>(
                builder: (context, scheduled, _) {
                  return Switch.adaptive(
                    value: provider.isDailyRestaurantsActive,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        provider.enableDailyNews(value);
                        scheduled.scheduledRestaurant(value);
                      }
                    },
                  );
                },
              ),
            ),
          ),
        ],
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}