import 'package:submission1_restaurant_app/data/model/categories.dart';
import 'package:submission1_restaurant_app/data/model/restaurant_detail.dart';

const String BASE_URL = 'https://restaurant-api.dicoding.dev/';


class Restaurant {
  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.address,
      required this.categories,
      required this.menus
      }
    );

  String id;
  String name;
  String description;
  String pictureId;
  String address;
  String city;
  double rating;
  List<Categories> categories;
  Menus menus;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      pictureId: json["pictureId"],
      address: json["address"] == null ? null : json["address"],
      city: json["city"],
      rating: json["rating"].toDouble(),
      categories: List<Categories>.from(json['categories'].map((x) => Categories.fromJson(x))),
      menus: Menus.fromJson(json["menus"]));
}
