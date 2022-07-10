import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1_restaurant_app/common/navigation.dart';
import 'package:submission1_restaurant_app/data/model/favorite.dart';
import 'package:submission1_restaurant_app/data/model/restaurant_list.dart';
import 'package:submission1_restaurant_app/provider/database_provider.dart';
import 'package:submission1_restaurant_app/ui/restaurant_detail_page.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({required this.restaurant});
 
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child){
        return FutureBuilder<bool>( 
          future: provider.isFavorited(restaurant.id),
          builder: (context,snapshot){
            var favorite = Favorite(id: restaurant.id, pictureId: restaurant.pictureId, name: restaurant.name, city: restaurant.city, rating: restaurant.rating.toString());
            var isFavorited = snapshot.data ?? false;
            return Material(
              child: ListTile(
              contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: Image.network(
                 "https://restaurant-api.dicoding.dev/images/medium/" +
                restaurant.pictureId,
              width: 100,
              ),
              title: Text(restaurant.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.city),
                  Row(
                    children: [ const
                      Icon(Icons.star_rate, size: 15),
                      Text(restaurant.rating.toString()),
                    ],
                  )
                ],
              ),
              trailing: isFavorited
                    ? IconButton(
                        icon: const Icon(Icons.favorite),
                        onPressed: () => provider.removeFavorite(restaurant.id),
                      )
                    : IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () => provider.addFavorite(favorite),
                    ),
              onTap: () {
                Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                arguments: restaurant.id);
              },
            )
          );
          }
        );
      }
    );
  }
}