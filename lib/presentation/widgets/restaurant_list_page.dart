import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:restaurant_app/domain/models/restaurant.dart';
import 'package:restaurant_app/presentation/widgets/pages/restaurant_detail.dart';

class RestaurantListPage extends StatelessWidget {
  static const routeName = '/restaurant_list';

  const RestaurantListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant'),
        bottom: const PreferredSize(
            preferredSize: Size.fromHeight(20),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(bottom: 8, left: 16),
                child: Text('Recommendation restaurant for you'),
              ),
            )),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString('assets/local_restaurant.json'),
        builder: (context, snapshot) {
          final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
          return ListView.builder(
            itemCount: restaurants.length,
            itemBuilder: (context, index) {
              return _buildRestaurantItem(context, restaurants[index]);
            },
          );
        },
      ),
    );
  }
}

List<Restaurant> parseRestaurants(String? data) {
  if (data == null) {
    return [];
  }

  final Map parsed = json.decode(data);
  return List<Restaurant>.from(
      parsed['restaurants'].map((json) => Restaurant.fromJson(json)));
}

Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
    leading: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      child: Image.network(
        restaurant.pictureId,
        width: 100.0,
        fit: BoxFit.cover,
        errorBuilder: (ctx, error, _) => const SizedBox(
          width: 100,
          child: Icon(Icons.error),
        ),
      ),
    ),
    title: Text(
      restaurant.name,
      maxLines: 1,
    ),
    subtitle: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            const Icon(Icons.pin_drop, color: Colors.blue),
            const SizedBox(width: 8),
            Text(restaurant.city),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          children: <Widget>[
            const Icon(Icons.star, color: Colors.blue),
            const SizedBox(width: 8),
            Text(restaurant.rating.toString()),
          ],
        ),
      ],
    ),
    onTap: () {
      Navigator.pushNamed(context, RestaurantDetailPage.routeName,
        arguments: restaurant);
    },
  );
}
