import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_statemanagments/constants/my_app_icons.dart';
import 'package:mvvm_statemanagments/models/movie_search_list.dart';
import 'package:mvvm_statemanagments/repository/movies_repository.dart';
import 'package:mvvm_statemanagments/services/init_getit.dart';
import 'package:mvvm_statemanagments/services/navigation_servicer.dart';

import '../widgets/favorite_widget.dart';
import '../widgets/movie_widget.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {

  final List<Search> _movies = [];
  int _currentPage = 1;
  bool _isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchMovies();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
      _fetchMovies();
    }
  }

  Future<void> _fetchMovies() async {
    if(_isLoading)
      return;
    setState(() {
      _isLoading = true;
    });
    try {
      final result = await getIt<MoviesRepository>().fetchMovies(page: _currentPage);
      if(mounted){
        setState(() {
          _movies.addAll(result);
          _currentPage++;
          _isLoading = false;
        });
      }
    } catch (e) {
      getIt<NavigationService>().showSnackbar("Failed to fetch movies $e");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movies List'),
        actions: [
          FavoriteWidget(isFavorite: true, onPressed: () async {
            // getIt<NavigationService>().showSnackbar();
            // getIt<NavigationService>().navigateTo(FavoritesScreen());
            // final result = await getIt<MoviesRepository>().fetchMovies();
            // log("result $result");
          }),
          IconButton(
            icon: Icon(MyAppIcons.darkMode),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.builder(
        controller: _scrollController,
        itemCount: _movies.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
          if(index < _movies.length){
            return MovieWidget(
              isFavorite: false,
              movie: _movies[index],
            );
          } else {
            return const CircularProgressIndicator.adaptive();
          }
      }),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}