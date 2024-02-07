import 'dart:math';
import 'dart:ui';
import 'dart:isolate';

import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response/restaurant_list.dart';
import 'package:restaurant_app/main.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().getRestaurantList();

    final Random random = Random();
    final int randomRestaurantIndex = random.nextInt(result.restaurants.length);
    final RestaurantOverview restaurant = result.restaurants[randomRestaurantIndex];

    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, restaurant);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}