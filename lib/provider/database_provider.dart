import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/response/restaurant_list.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  late ResultState _state = ResultState.noData;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<RestaurantOverview> _bookmarks = [];
  List<RestaurantOverview> get bookmarks => _bookmarks;

  void _getFavorites() async {
    _bookmarks = await databaseHelper.getBookmarks();
    if (_bookmarks.isNotEmpty) {
      _state = ResultState.hasData;
    } else {
      _state = ResultState.noData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addFavorite(RestaurantOverview article) async {
    try {
      await databaseHelper.insertFavorite(article);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }

  Future<bool> isFavorite(String id) async {
    final bookmarkedArticle = await databaseHelper.getRestaurantById(id);
    return bookmarkedArticle.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultState.error;
      _message = 'Error: $e';
      notifyListeners();
    }
  }
}
