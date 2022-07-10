//import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/widget/restaurant_list_card.dart';
import 'package:submission1_restaurant_app/provider/restaurant_provider.dart';
import 'package:provider/provider.dart';

import '../widget/platform_widget.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list_page';
  Widget _buildList(BuildContext context) {
       return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: state.result.count,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return CardRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(
            child: Column(
              children: [
                Image.asset("assets/images/data-error.png", width: 150),
                const SizedBox(height: 5),
                const Text("Gagal untuk mendapatkan data"),
              ],
            ),
          );
        } else if (state.state == ResultState.Error) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset("assets/images/connection-lost.png", width: 150),
                const SizedBox(height: 5),
                const Text("Gagal untuk mendapatkan data"),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
              ],
            ),
          );
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CDXrestaurant'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CDXrestaurant'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
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

