import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_colors.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';
import 'package:mvvm_statemanagments/models/movie_details_model.dart';
import 'package:mvvm_statemanagments/repository/movies_repository.dart';
import 'package:mvvm_statemanagments/services/navigation_servicer.dart';
import 'package:mvvm_statemanagments/widgets/cached_image.dart';
import 'package:mvvm_statemanagments/widgets/genres_list_widget.dart';

import '../services/init_getit.dart';
import '../widgets/favorite_widget.dart';
import '../widgets/movie_widget.dart';

class MoviesDetails extends StatefulWidget {
  const MoviesDetails({super.key, required this.id});
  final String id;

  @override
  State<MoviesDetails> createState() => _MoviesDetailsState();
}

class _MoviesDetailsState extends State<MoviesDetails> {
  var _isLoading = false;
  var _movieDetails = MovieDetailsModel();

  @override
  void initState() {
    _fetchMovieDetails();
    super.initState();
  }

  Future<void> _fetchMovieDetails() async {
    if (_isLoading) return;
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await getIt<MoviesRepository>().fetchMovieDetails(
        id: widget.id,
      );
      if (mounted) {
        setState(() {
          _movieDetails = result;
          _isLoading = false;
        });
      }
    } catch (e) {
      getIt<NavigationService>().showSnackbar(
        "Failed to fetch movie details $e",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            if(_isLoading)
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            if(!_isLoading)
            Hero(
              tag: widget.id,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.45,
                width: double.infinity,
                child: CachedImage(
                  imageUrl: _movieDetails.poster ?? "",
                  height: 100,
                  width: 60,
                  fit: BoxFit.cover,
                ),
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
                                  _movieDetails.title ?? "",
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
                                    Text(_movieDetails.imdbRating ?? ""),
                                    Spacer(),
                                    Text(
                                      _movieDetails.released ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                GenresListWidget(
                                  genres: _movieDetails.genre?.split(",")  ?? [
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
                                      _movieDetails.director ?? "",
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
                                  children: [
                                    Text(
                                      "Writer: ",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _movieDetails.writer ?? "",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  _movieDetails.plot ?? "",
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
                                        _movieDetails.actors ?? "",
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
                                      genres: _movieDetails.language?.split(",")  ?? [
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
                                        _movieDetails.awards ?? "",
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
                            child: FavoriteWidget(
                              isFavorite: true,
                              onPressed: () {},
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
        ),
      ),
    );
  }
}
