import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/preferences/preferences_helper.dart';
import 'package:restaurant_app/presentation/pages/home_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_list_page.dart';
import 'package:restaurant_app/presentation/pages/restaurant_search_page.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/preference_provider.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  await notificationHelper.requestNotificationPermissions();

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
        ChangeNotifierProvider<PreferencesProvider>(
          create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                  sharedPreferences: SharedPreferences.getInstance())),
        ),
        ChangeNotifierProvider<SchedulingProvider>(
          create: (_) => SchedulingProvider(),
        ),
        ChangeNotifierProvider<DatabaseProvider>(
          create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
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
