import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/data/api/api_service.dart';
import 'package:submission1_restaurant_app/data/model/restaurant_search.dart';


enum StateResultSearch { 
  Loading, 
  NoData, 
  HasData, 
  Error 
}

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({required this.apiService, required String query}) {
    fetchAllRestaurantSearch(query);
  }

  RestaurantsSearch? _resultRestaurantsSearch;
  String _message = '';
  String _query = '';
  StateResultSearch? _state;

  String get message => _message;
  String get query => _query;
  RestaurantsSearch? get result => _resultRestaurantsSearch;
  StateResultSearch? get state => _state;

  Future<dynamic> fetchAllRestaurantSearch(String query) async {
    try {
      _state = StateResultSearch.Loading;
      _query = query;

      final restaurantSearch = await apiService.searchingRestaurant(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = StateResultSearch.NoData;
        notifyListeners();
        return _message = 'Restaurant Tidak dapat ditemukan';
      } else {
        _state = StateResultSearch.HasData;

        notifyListeners();
        return _resultRestaurantsSearch = restaurantSearch as RestaurantsSearch?;
      }
    } catch (e) {
      _state = StateResultSearch.Error;
      notifyListeners();
      return _message = 'Gagal Menampilkan Restoran yang dicari\n              Periksa Koneksi Anda';
    }
  }
}
