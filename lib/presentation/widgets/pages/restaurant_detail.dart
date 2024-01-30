import 'package:flutter/material.dart';
import 'package:restaurant_app/domain/models/menu.dart';
import 'package:restaurant_app/domain/models/restaurant.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;
  const RestaurantDetailPage({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              child: Image.network(restaurant.pictureId),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurant.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.pin_drop, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(restaurant.city),
                  ],
                ),
                Row(
                  children: <Widget>[
                    const Icon(Icons.star, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(restaurant.rating.toString()),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 4),
                Text(restaurant.description),
                const SizedBox(height: 16),
                const Text(
                  'Foods',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        restaurant.menus.foods.length,
                        (i) => _buildRestaurantMenuCard(restaurant,
                            MenuItem(name: restaurant.menus.foods[i].name))),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  'Drinks',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                        restaurant.menus.drinks.length,
                        (i) => _buildRestaurantMenuCard(restaurant,
                            MenuItem(name: restaurant.menus.drinks[i].name))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )));
  }
}

Widget _buildRestaurantMenuCard(Restaurant restaurant, MenuItem menu) {
  return Container(
      margin: const EdgeInsets.only(right: 16.0),
      width: 160.0,
      height: 90.0, // Set the desired card width
      child: Stack(
        children: <Widget>[
          ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
              ),
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5), BlendMode.srcOver),
                child: Image.network(
                  restaurant.pictureId,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
              bottom: 8,
              left: 8,
              child: SizedBox(
                width: 160.0,
                child: Text(
                  menu.name,
                  style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                  softWrap: true,
                ),
              ))
        ],
      ));
}
