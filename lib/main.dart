import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/response/restaurant_detail.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:restaurant_app/presentation/pages/restaurant_detail/restaurant_detail_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_list/restaurant_list_page.dart';

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
        nextScreen: const RestaurantListPage(),
        splashTransition: SplashTransition.fadeTransition,
      ),
      routes: {
        RestaurantListPage.routeName: (context) => const RestaurantListPage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
          restaurantId: ModalRoute.of(context)?.settings.arguments as String,
        ),
      },
    );
  }
}