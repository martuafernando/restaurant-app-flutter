import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/response/menu.dart';
import 'package:restaurant_app/data/model/response/restaurant_detail.dart';
import 'package:restaurant_app/presentation/widgets/platform_widget.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  const RestaurantDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}

Widget _buildAndroid(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Restaurant App'),
    ),
    body: _buildPage(context),
  );
}

Widget _buildIos(BuildContext context) {
  return CupertinoPageScaffold(
    navigationBar: const CupertinoNavigationBar(
      middle: Text('Restaurant App'),
      transitionBetweenRoutes: false,
    ),
    child: _buildPage(context),
  );
}

Widget _buildPage(BuildContext context) {
  return Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
    if (state.state == ResultState.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.state == ResultState.hasData) {
      return _buildTemplate(state.result.restaurant);
    }

    if (state.state == ResultState.noData) {
      return Center(
        child: Text(state.message),
      );
    }

    if (state.state == ResultState.error) {
      return AlertDialog(
        title: const Text('Error'),
        content: const Text('An error occurred. Cannot connect to server'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.popAndPushNamed(
                  context, RestaurantDetailPage.routeName);
            },
            child: const Text('Refresh'),
          ),
        ],
      );
    }

    return const Material(child: Text(''));
  });
}

Widget _buildTemplate(RestaurantDetail restaurant) {
  return SingleChildScrollView(
      child: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            child: Image.network(
                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                errorBuilder: (ctx, error, _) => const SizedBox(
                      width: 100,
                      child: Icon(Icons.error),
                    ),
                loadingBuilder: (context, child, loadingProgress) =>
                    _loadingBuilder(context, child, loadingProgress)),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                restaurant.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
  ));
}

Widget _buildRestaurantMenuCard(RestaurantDetail restaurant, MenuItem menu) {
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
                    'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, error, _) => const SizedBox(
                          width: double.infinity,
                          child: Icon(Icons.error),
                        ),
                    loadingBuilder: (context, child, loadingProgress) =>
                        _loadingBuilder(context, child, loadingProgress)),
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

Widget _loadingBuilder(
    BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
  if (loadingProgress == null) {
    return child;
  }

  return const Center(child: CircularProgressIndicator());
}
