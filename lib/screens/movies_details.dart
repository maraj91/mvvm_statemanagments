import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_colors.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';

import '../widgets/favorite_widget.dart';
import '../widgets/movie_widget.dart';

class MoviesDetails extends StatelessWidget {
  const MoviesDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies List'),
        actions: [
          IconButton(
            icon: Icon(MyAppIcons.delete, color: MyAppColors.redColor),
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