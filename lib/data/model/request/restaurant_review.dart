import 'dart:convert';

RestaurantReviewRequest restaurantReviewRequestFromJson(String str) => RestaurantReviewRequest.fromJson(json.decode(str));

String restaurantReviewRequestToJson(RestaurantReviewRequest data) => json.encode(data.toJson());

class RestaurantReviewRequest {
    final String id;
    final String name;
    final String review;

    RestaurantReviewRequest({
        required this.id,
        required this.name,
        required this.review,
    });

    factory RestaurantReviewRequest.fromJson(Map<String, dynamic> json) => RestaurantReviewRequest(
        id: json["id"],
        name: json["name"],
        review: json["review"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
    };
}
