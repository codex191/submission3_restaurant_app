import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1_restaurant_app/common/navigation.dart';
import 'package:submission1_restaurant_app/data/model/favorite.dart';
import 'package:submission1_restaurant_app/data/model/restaurant_list.dart';
import 'package:submission1_restaurant_app/provider/database_provider.dart';
import 'package:submission1_restaurant_app/ui/restaurant_detail_page.dart';

class CardFavoriteRestaurant extends StatelessWidget {
  final Favorite restaurant;
  const CardFavoriteRestaurant({required this.restaurant});
 
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child){
        var id = restaurant.id as String;
        return FutureBuilder<bool>( 
          future: provider.isFavorited(id),
          builder: (context,snapshot){
            var isFavorited = snapshot.data ?? false;
            var pictureId = restaurant.pictureId as String;
            var name = restaurant.name as String;
            var city = restaurant.city as String;
            return Material(
              child: ListTile(
              contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: Image.network(
                 "https://restaurant-api.dicoding.dev/images/medium/" +
                pictureId,
              width: 100,
              ),
              title: Text(name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(city),
                  Row(
                    children: [ const
                      Icon(Icons.star_rate, size: 15),
                      Text(restaurant.rating.toString()),
                    ],
                  )
                ],
              ),
              trailing:
                IconButton(
                 icon: const Icon(Icons.delete),
                  onPressed: () => provider.removeFavorite(id),
                ),
              onTap: () {
                Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                arguments: restaurant.id);
              },
              ),
            );
            }
        );
      }
    );
  }
}