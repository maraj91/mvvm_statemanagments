import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';
import 'package:mvvm_statemanagments/view_models/favorites_provider.dart';
import 'package:mvvm_statemanagments/widgets/movie_widget.dart';
import 'package:provider/provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    final FavoritesProvider _favoritesProvider = Provider.of<FavoritesProvider>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
          title: Text('Favorites List'),
        actions: [
          IconButton(
            icon: Icon(
              MyAppIcons.delete,
              color: Colors.red,
            ),
            onPressed: () {
              _favoritesProvider.clearFavorites();
            },
          ),
        ],
      ),
      body:
      _favoritesProvider.favorites.isEmpty ?
      const Center(
        child: Text('No favorites yet', style: TextStyle(color: Colors.grey),),
      ) :
      Consumer(
        builder: (context, FavoritesProvider favoriteProvider, child) {
          return ListView.builder(
            itemCount: _favoritesProvider.favorites.length,
            itemBuilder: (context, index) {
              return ChangeNotifierProvider.value(
                value: _favoritesProvider.favorites.reversed.toList()[index],
                child: MovieWidget(),
              );
            },
          );
        },
      ),
    );
  }
}
