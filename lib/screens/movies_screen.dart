import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';
import 'package:mvvm_statemanagments/repository/movies_repository.dart';
import 'package:mvvm_statemanagments/screens/favorites_screen.dart';
import 'package:mvvm_statemanagments/services/api_service.dart';
import 'package:mvvm_statemanagments/services/init_getit.dart';
import 'package:mvvm_statemanagments/services/navigation_servicer.dart';

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
          FavoriteWidget(isFavorite: true, onPressed: () async {
            // getIt<NavigationService>().showSnackbar();
            // getIt<NavigationService>().navigateTo(FavoritesScreen());
            final result = await getIt<MoviesRepository>().fetchMovies();
            log("result $result");
          }),
          IconButton(
            icon: Icon(MyAppIcons.darkMode),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
          itemBuilder: (context, index) {
        return MovieWidget(
          isFavorite: false,
        );
      }),
    );
  }
}