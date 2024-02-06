// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/response/restaurant_detail.dart';
import 'package:restaurant_app/data/model/response/restaurant_list.dart';
import 'package:restaurant_app/data/model/response/restaurant_search.dart';

void main() {
  test('should parse json restaurant list correctly', () {
    // Arrange
    final restaurantListJson = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
        {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description":
              "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
          "pictureId": "25",
          "city": "Gorontalo",
          "rating": 4
        }
      ]
    };

    // Act
    final RestaurantListResponse restaurantList =
        RestaurantListResponse.fromJson(restaurantListJson);

    // Assert
    expect(
        restaurantList.restaurants[0].id,
        (restaurantListJson['restaurants'] as List<Map<String, dynamic>>)[0]
            ['id']);
    expect(
        restaurantList.restaurants[0].name,
        (restaurantListJson['restaurants'] as List<Map<String, dynamic>>)[0]
            ['name']);
  });

  test('should parse json restaurant detail correctly', () {
    // Arrange
    final restaurantDetailJson = {
      "error": false,
      "message": "success",
      "restaurant": {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. ...",
        "city": "Medan",
        "address": "Jln. Pandeglang no 19",
        "pictureId": "14",
        "categories": [
          {"name": "Italia"},
          {"name": "Modern"}
        ],
        "menus": {
          "foods": [
            {"name": "Paket rosemary"},
            {"name": "Toastie salmon"}
          ],
          "drinks": [
            {"name": "Es krim"},
            {"name": "Sirup"}
          ]
        },
        "rating": 4.2,
        "customerReviews": [
          {
            "name": "Ahmad",
            "review": "Tidak rekomendasi untuk pelajar!",
            "date": "13 November 2019"
          }
        ]
      }
    };

    // Act
    final RestaurantDetailResponse restaurantDetail =
        RestaurantDetailResponse.fromJson(restaurantDetailJson);

    // Assert
    expect(restaurantDetail.restaurant.id,
        (restaurantDetailJson['restaurant'] as Map<String, dynamic>)['id']);
    expect(restaurantDetail.restaurant.id,
        (restaurantDetailJson['restaurant'] as Map<String, dynamic>)['id']);
  });

  test('should parse json restaurant detail correctly', () {
    // Arrange
    final restaurantSearchJson = {
      "error": false,
      "founded": 1,
      "restaurants": [
        {
          "id": "fnfn8mytkpmkfw1e867",
          "name": "Makan mudah",
          "description":
              "But I must explain to you how all this mistaken idea of denouncing pleasure and praising pain was born and I will give you a complete account of the system, ...",
          "pictureId": "22",
          "city": "Medan",
          "rating": 3.7
        }
      ]
    };

    // Act
    final RestaurantSearchResponse restaurantSearch =
        RestaurantSearchResponse.fromJson(restaurantSearchJson);

    // Assert
    expect(
        restaurantSearch.restaurants[0].id,
        (restaurantSearchJson['restaurants'] as List<Map<String, dynamic>>)[0]
            ['id']);
    expect(
        restaurantSearch.restaurants[0].name,
        (restaurantSearchJson['restaurants'] as List<Map<String, dynamic>>)[0]
            ['name']);
  });
}
