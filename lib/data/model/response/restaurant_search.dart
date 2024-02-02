import 'dart:convert';

import 'package:restaurant_app/data/model/response/restaurant_list.dart';

RestaurantSearchResponse restaurantSearchResponseFromJson(String str) => RestaurantSearchResponse.fromJson(json.decode(str));

String restaurantSearchResponseToJson(RestaurantSearchResponse data) => json.encode(data.toJson());

class RestaurantSearchResponse {
    final bool error;
    final int founded;
    final List<RestaurantOverview> restaurants;

    RestaurantSearchResponse({
        required this.error,
        required this.founded,
        required this.restaurants,
    });

    factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) => RestaurantSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantOverview>.from(json["restaurants"].map((x) => RestaurantOverview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}
