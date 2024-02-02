import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response/restaurant_search.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService});

  late RestaurantSearchResponse _restaurantList;
  late ResultState _state = ResultState.noData;
  String _message = 'Empty Data';

  String get message => _message;

  RestaurantSearchResponse get result => _restaurantList;

  ResultState get state => _state;

  Future<dynamic> searchRestaurant(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      
      final restaurant = await apiService.searchRestaurantList(query);
      
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      }

      _state = ResultState.hasData;
      notifyListeners();
      return _restaurantList = restaurant;

    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
