import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:restaurant_app/presentation/pages/home_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_list_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_search_page.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (Platform.isAndroid) {}

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantListProvider>(
          create: (_) => RestaurantListProvider(apiService: ApiService()),
          child: const RestaurantListPage(),
        ),
        ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (ctx) => RestaurantDetailProvider(apiService: ApiService()),
          child: const RestaurantDetailPage(),
        ),
        ChangeNotifierProvider<RestaurantSearchProvider>(
          create: (_) => RestaurantSearchProvider(apiService: ApiService()),
          child: const RestaurantSearchPage(),
        ),
      ],
      child: _template(),
    );
  }
}

Widget _template() {
  return MaterialApp(
    title: 'Restaurant App',
    theme: darkTheme,
    home: AnimatedSplashScreen(
      splash: 'assets/logo.png',
      nextScreen: ChangeNotifierProvider<RestaurantListProvider>(
        create: (_) => RestaurantListProvider(apiService: ApiService()),
        child: const HomePage(),
      ),
      splashTransition: SplashTransition.fadeTransition,
    ),
    routes: {
      HomePage.routeName: (context) => const HomePage(),
      RestaurantListPage.routeName: (context) => const RestaurantListPage(),
      RestaurantDetailPage.routeName: (context) {
        final restaurantId =
            ModalRoute.of(context)?.settings.arguments as String?;
        Provider.of<RestaurantDetailProvider>(context, listen: false)
            .fetchDetailRestaurant(restaurantId);
        return const RestaurantDetailPage();
      },
      RestaurantSearchPage.routeName: (context) => const RestaurantSearchPage(),
    },
  );
}
