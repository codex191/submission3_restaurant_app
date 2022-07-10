import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1_restaurant_app/provider/database_provider.dart';
import 'package:submission1_restaurant_app/widget/platform_widget.dart';
import 'package:submission1_restaurant_app/widget/restaurant_list_card.dart';
import 'package:submission1_restaurant_app/widget/restaurant_list_card_favorite.dart';

class FavoritesPage extends StatelessWidget {
  static const String favoritesTitle = 'Favorites';
 
  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(favoritesTitle),
        backgroundColor: Colors.green,
      ),
      body: _buildList(),
    );
  }
 
  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text(favoritesTitle),
      ),
      child: _buildList(),
    );
  }
 
  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return CardFavoriteRestaurant(restaurant: provider.favorites[index]);
            },
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
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