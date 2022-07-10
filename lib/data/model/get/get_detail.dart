import 'package:submission1_restaurant_app/data/model/restaurant.dart';

class GetDetailRestaurant {
  GetDetailRestaurant(
    {
      required this.error, 
      required this.message, 
      required this.restaurant
      }
    );

  bool error;
  String message;
  Restaurant restaurant;

  factory GetDetailRestaurant.fromJson(Map<String, dynamic> json) => GetDetailRestaurant(error: json["error"], message: json["message"], restaurant: Restaurant.fromJson(json["restaurant"]));
}
