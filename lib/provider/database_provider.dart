
import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/data/database/database_helper.dart';
import 'package:submission1_restaurant_app/data/model/favorite.dart';

enum ResultState { 
  Loading, 
  NoData, 
  HasData, 
  Error 
}

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Favorite> _favorites = [];
  List<Favorite> get favorites => _favorites;

  void _getFavorites() async {
    _favorites = await databaseHelper.getFavorite();
    if (_favorites.isNotEmpty) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Anda belum menambahkan restaurant yang difavoritkan';
    }
    notifyListeners();
  }

  void addFavorite(Favorite restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async => await databaseHelper.getFavoriteById(id);

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}