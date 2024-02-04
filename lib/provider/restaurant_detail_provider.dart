import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response/restaurant_detail.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService});

  late RestaurantDetailResponse _restaurantDetail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  RestaurantDetailResponse get result => _restaurantDetail;

  ResultState get state => _state;

  Future<dynamic> fetchDetailRestaurant(String? restaurantId) async {
    try {
      _state = ResultState.loading;
      
      if (restaurantId == null) {
        throw Exception('Cannot connect to server');
      }

      final restaurant = await apiService.getRestaurantDetail(restaurantId);

      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantDetail = restaurant;

    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
