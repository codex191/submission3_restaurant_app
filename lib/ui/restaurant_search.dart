import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:submission1_restaurant_app/common/styles.dart';
import 'package:submission1_restaurant_app/data/model/restaurant_search.dart';
import 'package:submission1_restaurant_app/provider/restaurant_search_provider.dart';
import 'package:submission1_restaurant_app/ui/restaurant_detail_page.dart';



class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/restaurant_search_page';
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  _RestaurantSearchPageState createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  String queries = '';
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.green,
      ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Consumer<SearchRestaurantProvider>(
                builder: (context, state, _) {
                  return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                          leading: const Icon(
                            Icons.search,
                            size: 30,
                          ),
                          title: TextField(
                            controller: _controller,
                            onChanged: (String value) {
                              setState(() {
                                queries = value;
                              });
                              if (value != '') {
                                state.fetchAllRestaurantSearch(value);
                              }
                            },
                            cursorColor: SearchColor,
                            decoration: const InputDecoration(
                                hintText: "Cari Restoran",
                                border: InputBorder.none),
                          ),
                        )
                      );
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                    child: _listSearchRestaurants(context),
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget _listSearchRestaurants(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == StateResultSearch.Loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == StateResultSearch.HasData) {
          return SizedBox(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: state.result!.restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = state.result!.restaurants;
                  return buildRestautantItem(restaurant[index], context);
                },
              ));
        } else if (state.state == StateResultSearch.NoData) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset("assets/images/data-error.png", width: 50),
                const SizedBox(height: 5),
                const Text("Tidak ada restaurant yang dicari"),
              ],
            ),
          );
        } else if (state.state == StateResultSearch.Error) {
          return Center(
            child: Column(
              children: [
                const SizedBox(height: 10),
                Image.asset("assets/images/connection-lost.png", width: 50),
                const SizedBox(height: 5),
                const Text("Mohon Periksa Koneksi Internet Anda"),
                const SizedBox(height: 10),
                const CircularProgressIndicator(),
                const SizedBox(height: 5),
              ],
            ),
          );
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }
}

Widget buildRestautantItem(RestaurantSearch restaurant, BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
          "https://restaurant-api.dicoding.dev/images/medium/" + restaurant.pictureId,
        width: 100,
      ),
        title: Text(restaurant.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(restaurant.city),
          Row(
            children: [ const
              Icon(Icons.star_rate, size: 15),
              Text(restaurant.rating.toString()),
            ],
          )
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, RestaurantDetailPage.routeName,
            arguments: restaurant.id);
      },
      ),
    );
}