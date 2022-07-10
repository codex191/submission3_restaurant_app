import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1_restaurant_app/data/api/api_service.dart';
import 'package:submission1_restaurant_app/widget/restaurant_detail_card.dart';
import '../provider/restaurant_detail_provider.dart';
import '../widget/platform_widget.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail_page';
  final String restaurantdetail;
  const RestaurantDetailPage({required this.restaurantdetail});
  Widget _buildDetail(BuildContext context) {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
    create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: restaurantdetail),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.Error) {
              return Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/data-error.png", width: 150),
                    const SizedBox(height: 5),
                    const Text("Gagal untuk mendapatkan data"),
                    //const Text("errr"),
                  ],
                ),
              );
            } else if (state.result == ResultState.NoData) {
              return Center(child: Text(state.message));
            } else if (state.state == ResultState.HasData) {
              var restaurant = state.result.restaurant;
              return CardRestaurantDetail(restaurant: restaurant);
            } else {
              return Center(
                child: Column(
                  children: [
                    Image.asset("assets/images/data-error.png", width: 150),
                    const SizedBox(height: 5),
                    const Text("Gagal untuk mendapatkan data"),
                  ],
                ),
              );
            }
        },
        ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CDXrestaurant'),
        backgroundColor: Colors.green,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon( 
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: _buildDetail(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CDXrestaurant'),
        transitionBetweenRoutes: false,
      ),
      child: _buildDetail(context),
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