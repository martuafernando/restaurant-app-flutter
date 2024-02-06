import 'package:restaurant_app/data/model/response/restaurant_list.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _instance;
  static Database? _database;

  DatabaseHelper._internal() {
    _instance = this;
  }

  factory DatabaseHelper() => _instance ?? DatabaseHelper._internal();

  static const String _tblBookmark = 'bookmarks';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      '$path/restaurant_favorite.db',
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tblBookmark (
             id TEXT PRIMARY KEY,
             name TEXT,
             description TEXT,
             pictureId TEXT,
             city TEXT,
             rating FLOAT
           )     
        ''');
      },
      version: 1,
    );

    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();

    return _database;
  }

  Future<void> insertFavorite(RestaurantOverview restaurant) async {
    final db = await database;
    await db!.insert(_tblBookmark, restaurant.toJson());
  }

  Future<List<RestaurantOverview>> getBookmarks() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_tblBookmark);

    return results.map((res) => RestaurantOverview.fromJson(res)).toList();
  }

  Future<Map> getRestaurantById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results = await db!.query(
      _tblBookmark,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String url) async {
    final db = await database;

    await db!.delete(
      _tblBookmark,
      where: 'id = ?',
      whereArgs: [url],
    );
  }
}
