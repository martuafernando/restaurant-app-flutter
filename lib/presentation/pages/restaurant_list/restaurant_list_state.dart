import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response/restaurant_list.dart';
import 'package:restaurant_app/presentation/pages/restaurant_list/restaurant_list_page.dart';
import 'package:restaurant_app/presentation/widgets/card_restaurant.dart';
import 'package:restaurant_app/presentation/widgets/platform_widget.dart';

class RestaurantListPageState extends State<RestaurantListPage> {
  late Future<RestaurantListResponse> _restaurants;

  @override
  void initState() {
    super.initState();
    _restaurants = ApiService().getRestaurantList();
  }

  Widget _buildList(BuildContext context) {
    return FutureBuilder(
        future: _restaurants,
        builder: (context, AsyncSnapshot<RestaurantListResponse> snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data?.restaurants.length,
              itemBuilder: (context, index) {
                var restaurant = snapshot.data?.restaurants[index];
                return CardRestaurant(restaurant: restaurant!);
              },
            );
          }

          if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Error'),
              content:
                  const Text('An error occurred. Cannot connect to server'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.popAndPushNamed(context, RestaurantListPage.routeName);
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
        title: const Text('Restaurant App'),
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
