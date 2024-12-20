import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/presentation/pages/home_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_search_page.dart';
import 'package:restaurant_app/presentation/widgets/card_restaurant.dart';
import 'package:restaurant_app/presentation/widgets/platform_widget.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({super.key});

  static const routeName = '/restaurant_list';

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantListProvider>(builder: (context, state, _) {
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
                    context, HomePage.routeName);
              },
              child: const Text('Refresh'),
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
        title: const Text('Restaurant App'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                Navigator.pushNamed(context, RestaurantSearchPage.routeName);
              },
            ),
          ),
        ],
      ),
      body: _buildList(context),
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
