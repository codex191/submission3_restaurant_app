import 'dart:ffi';

import 'package:sqflite/sqflite.dart';
import 'package:submission1_restaurant_app/data/model/favorite.dart';
import 'package:submission1_restaurant_app/data/model/restaurant_list.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;
 
  DatabaseHelper._internal() {
    _instance = this;
  }
 
  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();
 
  static const String _tblFavorite = 'Favorites';
 
  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblFavorite (
             id TEXT PRIMARY KEY,
             name TEXT,
             city TEXT,
             pictureId TEXT,
             rating TEXT
           )''',
           );
      },
      version: 1,
    );
 
    return db;
  }
 
  Future<Database?> get database async {
    _database ??= await _initializeDb();
 
    return _database;
  }

  Future<int> insertFavorite(Favorite restaurants) async {
    final Database? db = await database;
    return await db!.insert(_tblFavorite, restaurants.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<List<Favorite>> getFavorite() async {
    final Database? db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblFavorite);
 
    return results.map((res) => Favorite.fromMap(res)).toList();
  }

  Future<bool> getFavoriteById(String id) async {
    final Database? db = await database;
    List<Map<String, dynamic>> results = await db!.query(
        _tblFavorite,
        where: 'id = ?',
        whereArgs: [id],
  );
 
  if (results.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> removeFavorite(String id) async {
  final db = await database;
 
  await db!.delete(
    _tblFavorite,
    where: 'id = ?',
    whereArgs: [id],
  );
}
}