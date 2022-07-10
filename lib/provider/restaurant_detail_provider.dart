import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/data/api/api_service.dart';
import 'package:submission1_restaurant_app/data/model/get/get_detail.dart';

enum ResultState { 
  Loading, 
  NoData, 
  HasData, 
  Error 
}

class RestaurantDetailProvider extends ChangeNotifier {
  late final ApiService apiService;
  String id;

  RestaurantDetailProvider({
    required this.apiService, 
    required this.id}) {
    _fetchAllRestaurant(id);
  }

  late GetDetailRestaurant _restaurant;
  String _message = '';
  late ResultState _state;
  String get message => _message;
  GetDetailRestaurant get result => _restaurant;
  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurantdetail = await apiService.detailRestaurant(id);
      if (restaurantdetail.restaurant.id.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurant = restaurantdetail;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Gagal Menampilkan Detail Restoran\n              Periksa Koneksi Anda';
    }
  }
}