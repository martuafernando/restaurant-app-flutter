import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/response/restaurant_detail.dart';
import 'package:restaurant_app/data/model/response/restaurant_list.dart';
import 'package:restaurant_app/data/model/response/restaurant_search.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$_baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant list');
    }
  }

  Future<RestaurantDetailResponse> getRestaurantDetail(String restaurantId) async {
    final response = await http.get(Uri.parse("$_baseUrl/detail/$restaurantId"));
    if (response.statusCode == 200) {
      return RestaurantDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant list');
    }
  }

  Future<RestaurantSearchResponse> searchRestaurantList(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to get restaurant list');
    }
  }
}