import 'package:flutter/material.dart';
import 'package:restaurant_app/presentation/pages/restaurant_detail/restaurant_detail_state.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String restaurantId;
  const RestaurantDetailPage({super.key, required this.restaurantId});
  
  @override
  State<StatefulWidget> createState() => RestaurantDetailState();
}