import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';

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
          FavoriteWidget(isFavorite: true, onPressed: () {

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
        return MovieWidget();
      }),
    );
  }
}