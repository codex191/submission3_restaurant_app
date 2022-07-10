import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/data/api/api_service.dart';
import 'package:submission1_restaurant_app/data/model/restaurant_list.dart';


enum ResultState { 
  Loading, 
  NoData, 
  HasData, 
  Error 
}

class RestaurantProvider extends ChangeNotifier {
  late final ApiService apiService;

  RestaurantProvider({
    required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantList _restaurant;
  String _message = '';
  late ResultState _state;

  String get message => _message;
  RestaurantList get result => _restaurant;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaura = await apiService.listRestaurant();
      if (restaura.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurant = restaura;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Gagal Menampilkan Daftar Restoran\n              Periksa Koneksi Anda';
    }
  }
}
