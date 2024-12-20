import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/response/restaurant_list.dart';
import 'package:restaurant_app/presentation/pages/restaurant_detail_page.dart';
import 'package:restaurant_app/provider/database_provider.dart';

class CardRestaurant extends StatelessWidget {
  final RestaurantOverview restaurant;

  const CardRestaurant({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavorite(restaurant.id),
        builder: (context, snapshot) {
          var isBookmarked = snapshot.data ?? false;
          return ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            leading: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              child: Image.network(
                'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
                width: 100.0,
                fit: BoxFit.cover,
                errorBuilder: (ctx, error, _) => const SizedBox(
                  width: 100,
                  child: Icon(Icons.error),
                ),
                loadingBuilder: (context, child, loadingProgress) => SizedBox(
                  width: 100,
                  child: _loadingBuilder(context, child, loadingProgress),
                ),
              ),
            ),
            title: Text(
              restaurant.name,
              maxLines: 1,
            ),
            subtitle: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    const Icon(Icons.pin_drop, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(restaurant.city),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: <Widget>[
                    const Icon(Icons.star, color: Colors.blue),
                    const SizedBox(width: 8),
                    Text(restaurant.rating.toString()),
                  ],
                ),
              ],
            ),
            trailing: isBookmarked
                ? IconButton(
                    icon: const Icon(Icons.favorite),
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () => provider.removeFavorite(restaurant.id),
                  )
                : IconButton(
                    icon: const Icon(Icons.favorite_border),
                    color: Theme.of(context).colorScheme.secondary,
                    onPressed: () => provider.addFavorite(restaurant),
                  ),
            onTap: () {
              Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                  arguments: restaurant.id);
            },
          );
        },
      );
    });
  }

  Widget _loadingBuilder(
      BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
    if (loadingProgress == null) {
      return child;
    }

    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
