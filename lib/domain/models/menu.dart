class Menus {
  final List<MenuItem> foods;
  final List<MenuItem> drinks;

  Menus({
    required this.foods,
    required this.drinks,
  });

  factory Menus.fromJson(Map<String, dynamic> json) {
    return Menus(
      foods: (json['foods'] as List<dynamic>)
          .map((food) => MenuItem.fromJson(food))
          .toList(),
      drinks: (json['drinks'] as List<dynamic>)
          .map((drink) => MenuItem.fromJson(drink))
          .toList(),
    );
  }
}

class MenuItem {
  final String name;

  MenuItem({
    required this.name,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    return MenuItem(
      name: json['name'],
    );
  }
}