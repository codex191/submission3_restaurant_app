import 'package:flutter/material.dart';
import 'package:submission1_restaurant_app/data/model/restaurant.dart';
import 'package:submission1_restaurant_app/widget/fitur_like.dart';


class CardRestaurantDetail extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurantDetail({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
           child: Column(
          children: [
                  Image.network("https://restaurant-api.dicoding.dev/images/medium/" + restaurant.pictureId),
                  Padding(
                    padding: EdgeInsets.zero,
                    child: 
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Container(
                                      padding: const EdgeInsets.only(left: 14.0, top: 14.0),
                                      child:
                                      Container(
                                        color: Colors.white,
                                        child: Like_Button())
                                      ),
                                    ],
                                  ),
                                  Text(
                                    restaurant.name,
                                    style: heading,
                                    ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(), const
                                      Icon(
                                        Icons.location_on,
                                         color: Colors.white,
                                      ),
                                      Text(
                                        restaurant.city,
                                        style: city_rating,
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 18.0),
                                ],
                              ),
                            ),
                          ],
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: 
                            const Text("Deskripsi:", style: heading_deskripsi,),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 6.0),
                            child: 
                            Text(restaurant.description, style: deskripsi,),
                          ),
                          const SizedBox(height: 18.0),
                          Container(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: 
                            const Text("Foods:", style: heading_food_drinks,),
                          ),
                          Container(
                            height: 190.0,
                            width: 150.0,
                            child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: restaurant.menus.foods.map((foods) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset('assets/images/spaghetti.jpg',
                                          height: 150.0, width: 150.0, fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(foods.name),
                                    ],
                                  ),
                                ),
                              );
                            }
                          ).toList(),
                          ),
                          ),
                          const SizedBox(height: 18.0),
                          Container(
                            padding: const EdgeInsets.only(left: 4.0),
                            child: 
                            const Text("Drinks:", style: heading_food_drinks,),
                          ),
                          Container(
                            height: 190.0,
                            width: 150.0,
                            child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: restaurant.menus.drinks.map((drinks) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Card(
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.asset('assets/images/drinks.png',
                                          height: 150.0, width: 150.0, fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(drinks.name),
                                    ],
                                  ),
                                ),
                              );
                            }
                          ).toList(),
                          ),
                          ),
                        ],
                      ),
                      ],
                    ),
                    ),
                    ),
              ],
        ),
        ),
      ),
    );
  }
}

const heading =  TextStyle(
  fontSize:  28,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const heading_deskripsi =  TextStyle(
  fontSize:  18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const deskripsi =  TextStyle(
  fontSize:  14,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);


const heading_food_drinks =  TextStyle(
  fontSize:  18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const city_rating =  TextStyle(
  fontSize:  18,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);

const desc_food_drink =  TextStyle(
  fontSize:  14,
  fontWeight: FontWeight.bold,
  color: Colors.black,
);