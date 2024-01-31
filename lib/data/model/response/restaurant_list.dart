import 'dart:convert';

RestaurantListResponse restaurantListResponseFromJson(String str) => RestaurantListResponse.fromJson(json.decode(str));

String restaurantListResponseToJson(RestaurantListResponse data) => json.encode(data.toJson());

class RestaurantListResponse {
    final bool error;
    final String message;
    final int count;
    final List<RestaurantOverview> restaurants;

    RestaurantListResponse({
        required this.error,
        required this.message,
        required this.count,
        required this.restaurants,
    });

    factory RestaurantListResponse.fromJson(Map<String, dynamic> json) => RestaurantListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantOverview>.from(json["restaurants"].map((x) => RestaurantOverview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class RestaurantOverview {
    final String id;
    final String name;
    final String description;
    final String pictureId;
    final String city;
    final double rating;

    RestaurantOverview({
        required this.id,
        required this.name,
        required this.description,
        required this.pictureId,
        required this.city,
        required this.rating,
    });

    factory RestaurantOverview.fromJson(Map<String, dynamic> json) => RestaurantOverview(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}
