import 'package:flutter/cupertino.dart';

class Favorite {
  Favorite({
    required this.id,
    required this.pictureId,
    required this.name,
    required this.city,
    required this.rating,
  });

  String? id;
  String? pictureId;
  String? name;
  String? city;
  String? rating;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'pictureId': pictureId,
      'name': name,
      'city': city,
      'rating' : rating,
    };
  }

  Favorite.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    pictureId = map['pictureId'];
    name = map['name'];
    city = map['city'];
    rating = map['rating'];
  }
}
