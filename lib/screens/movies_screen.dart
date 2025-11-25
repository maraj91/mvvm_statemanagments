import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';
import 'package:mvvm_statemanagments/constants/my_theme_data.dart';
import 'package:mvvm_statemanagments/repository/movies_repository.dart';
import 'package:mvvm_statemanagments/screens/favorites_screen.dart';
import 'package:mvvm_statemanagments/services/api_service.dart';
import 'package:mvvm_statemanagments/services/init_getit.dart';
import 'package:mvvm_statemanagments/services/navigation_servicer.dart';
import 'package:mvvm_statemanagments/view_models/movies_provider.dart';
import 'package:mvvm_statemanagments/view_models/theme_provider.dart';
import 'package:mvvm_statemanagments/widgets/my_error_widget.dart';
import 'package:provider/provider.dart';

import '../widgets/favorite_widget.dart';
import '../widgets/movie_widget.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
        actions: [
          FavoriteWidget(
            isFavorite: true,
            onPressed: () async {
              getIt<NavigationService>().navigateTo(FavoritesScreen());
            },
          ),
          Consumer(
            builder: (context, ThemeProvider themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.themeMode == MyThemeData.getDarkTheme()
                      ? MyAppIcons.darkMode
                      : MyAppIcons.lightMode,
                ),
                onPressed: () {
                  themeProvider.toggleTheme();
                },
              );
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, MoviesProvider moviesProvider, child) {
          if (moviesProvider.isLoading && moviesProvider.movies.isEmpty) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (moviesProvider.error.isNotEmpty) {
            return Center(
              child: MyErrorWidget(
                errorMessage: moviesProvider.error,
                retryFunction: () {},
              ),
            );
          }
          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (!moviesProvider.isLoading &&
                  moviesProvider.movies.isNotEmpty &&
                  notification.metrics.pixels ==
                      notification.metrics.maxScrollExtent) {
                moviesProvider.fetchMovies();
              }
              return true;
            },
            child: ListView.builder(
              itemCount: moviesProvider.movies.length,
              itemBuilder: (context, index) {
                return  ChangeNotifierProvider.value(
                    value: moviesProvider.movies[index],
                    child:  MovieWidget(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
