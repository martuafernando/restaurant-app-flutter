import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:restaurant_app/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_list_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_search_page.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: AnimatedSplashScreen(
        splash: 'assets/logo.png',
        nextScreen: ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
          child: const RestaurantListPage(),
        ),
        splashTransition: SplashTransition.fadeTransition,
      ),
      routes: {
        RestaurantListPage.routeName: (context) => ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
          child: const RestaurantListPage(),
        ),
        RestaurantDetailPage.routeName: (context) => ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(apiService: ApiService(), restaurantId: ModalRoute.of(context)?.settings.arguments as String),
          child: const RestaurantDetailPage(),
        ),
        RestaurantSearchPage.routeName: (context) => ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) => RestaurantSearchProvider(apiService: ApiService()),
          child: const RestaurantSearchPage(),
        ),
      },
    );
  }
}