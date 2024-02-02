import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/presentation/widgets/card_restaurant.dart';
import 'package:restaurant_app/presentation/widgets/platform_widget.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';

class RestaurantSearchPage extends StatelessWidget {
  const RestaurantSearchPage({super.key});

  static const routeName = '/restaurant_search';

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantSearchProvider>(builder: (context, state, _) {
      if (state.state == ResultState.loading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.state == ResultState.hasData) {
        return ListView.builder(
          shrinkWrap: true,
          itemCount: state.result.restaurants.length,
          itemBuilder: (context, index) {
            var restaurant = state.result.restaurants[index];
            return CardRestaurant(restaurant: restaurant);
          },
        );
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
                    context, RestaurantSearchPage.routeName);
              },
              child: const Text('Close'),
            ),
          ],
        );
      }

      return const Material(child: Text(''));
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Consumer<RestaurantSearchProvider>(
                  builder: (context, state, _) {
                return TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 24.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(32.0),
                      borderSide: const BorderSide(width: 1.0),
                    ),
                  ),
                  onChanged: (query) => state.searchRestaurant(query),
                );
              })),
          Expanded(
            child: _buildList(context),
          )
        ],
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurant App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
