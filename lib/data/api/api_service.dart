import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../model/get/get_detail.dart';
import '../model/restaurant_list.dart';
import '../model/restaurant_search.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';

  Client? client;
  ApiService({this.client}) {
    client ??= Client();
  }

    Future<RestaurantList> listRestaurant() async {
    final response = await http.get(Uri.parse(baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(
          json.decode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Failed to load list restaurant');
    }
  }

  Future<GetDetailRestaurant> detailRestaurant(String id) async {
    final response = await http.get(Uri.parse("${baseUrl}detail/$id"));
    if (response.statusCode == 200) {
      return GetDetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail Restaurant');
    }
  }

  Future<RestaurantsSearch> searchingRestaurant(String query) async {
    final response = await http.get(Uri.parse("${baseUrl}search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantsSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load seacrh restaurant');
    }
  }
}