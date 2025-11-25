import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_colors.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';
import 'package:mvvm_statemanagments/services/navigation_servicer.dart';
import 'package:mvvm_statemanagments/widgets/cached_image.dart';
import 'package:mvvm_statemanagments/widgets/genres_list_widget.dart';

import '../services/init_getit.dart';
import '../widgets/favorite_widget.dart';
import '../widgets/movie_widget.dart';

class MoviesDetails extends StatelessWidget {
  const MoviesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.45,
              width: double.infinity,
              child: CachedImage(
                imageUrl:
                    'https://m.media-amazon.com/images/I/81dae9nZFBS._AC_UF894,1000_QL80_.jpg',
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
                                const Text(
                                  'Movie Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Row(
                                  children: [
                                    Icon(
                                      MyAppIcons.star,
                                      color: MyAppColors.startColor,
                                      size: 20,
                                    ),
                                    Text('4.5'),
                                    Spacer(),
                                    Text(
                                      "Release date",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                const GenresListWidget(
                                  genres: [
                                    "Action",
                                    "Comedy",
                                    "Drama",
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Overview ' * 100,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
