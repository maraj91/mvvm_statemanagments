import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/models/movie_search_list.dart';
import 'package:mvvm_statemanagments/screens/movies_details.dart';
import 'package:mvvm_statemanagments/services/init_getit.dart';
import 'package:mvvm_statemanagments/services/navigation_servicer.dart';
import 'package:mvvm_statemanagments/view_models/favorites_provider.dart';
import 'package:provider/provider.dart';

import '../constants/my_app_colors.dart';
import '../constants/my_app_icons.dart';
import 'cached_image.dart';
import 'favorite_widget.dart';
import 'genres_list_widget.dart';

class MovieWidget extends StatelessWidget {
  const MovieWidget({super.key});
  // final Search? movie;

  @override
  Widget build(BuildContext context) {
    final movie = Provider.of<Search>(context);
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          getIt<NavigationService>().navigateTo(MoviesDetails(movie: movie));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: IntrinsicWidth(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedImage(
                    imageUrl: movie.poster,
                    height: 100,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Icon(
                            MyAppIcons.star,
                            color: MyAppColors.startColor,
                            size: 20,
                          ),
                          Text('NA'),
                        ],
                      ),
                      const SizedBox(height: 4),
                      GenresListWidget(genres: [movie.type ?? ""]),
                      Row(
                        children: [
                          const Icon(
                            MyAppIcons.date,
                            color: MyAppColors.blue,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(movie.year ?? "NA"),
                          const Spacer(),
                          Consumer(
                            builder:
                                (context, FavoritesProvider favoriteProvider, child,) {
                                  return FavoriteWidget(
                                    isFavorite: favoriteProvider.isFavorite(movie,),
                                    onPressed: () {
                                      favoriteProvider.toggleFavorite(movie);
                                    },
                                  );
                                },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
