import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_colors.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';
import 'package:mvvm_statemanagments/models/movie_search_list.dart';
import 'package:mvvm_statemanagments/services/navigation_servicer.dart';
import 'package:mvvm_statemanagments/view_models/movies_provider.dart';
import 'package:mvvm_statemanagments/widgets/cached_image.dart';
import 'package:mvvm_statemanagments/widgets/genres_list_widget.dart';
import 'package:mvvm_statemanagments/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

import '../services/init_getit.dart';
import '../view_models/favorites_provider.dart';
import '../widgets/favorite_widget.dart';

class MoviesDetails extends StatelessWidget {
  const MoviesDetails({super.key, required this.movie});
  final Search movie;

  Future<void> _loadMovieDetails(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MoviesProvider>(context,listen: false).fetchMovieDetails(movie.imdbID ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: _loadMovieDetails(context),
          builder: (context, snapshot) {
            final movieDetails = Provider.of<MoviesProvider>(context).movieDetails;
            if(snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return MyErrorWidget(
                errorMessage: "Something went wrong!",
                retryFunction: () {},
              );
            }
            return Stack(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height * 0.45,
                  width: double.infinity,
                  child: CachedImage(
                    imageUrl: movieDetails.poster,
                    height: 100,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MediaQuery.sizeOf(context).height * 0.40),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 25),
                            child: Material(
                              elevation: 5,
                              borderRadius: BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 25),
                                    Text(
                                      movieDetails.title ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          MyAppIcons.star,
                                          color: MyAppColors.startColor,
                                          size: 20,
                                        ),
                                        Text(movieDetails.imdbRating ?? ""),
                                        Spacer(),
                                        Text(
                                          movieDetails.released ?? "",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    GenresListWidget(
                                      genres: movieDetails.genre?.split(",")  ?? [
                                        "NA"
                                      ]
                                      ,
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Director: ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          movieDetails.director ?? "",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Writer: ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            movieDetails.writer ?? "",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      movieDetails.plot ?? "",
                                      textAlign: TextAlign.justify,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Actors: ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            movieDetails.actors ?? "",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Text(
                                          "Language: ",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GenresListWidget(
                                          genres: movieDetails.language?.split(",")  ?? [
                                            "NA"
                                          ]
                                          ,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Awards: ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            movieDetails.awards ?? "",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).cardColor,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surface.withValues(alpha: 0.4),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Consumer(
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
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    getIt<NavigationService>().navigatorKey.currentState?.pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: MyAppColors.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(MyAppIcons.arrowBack),
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
