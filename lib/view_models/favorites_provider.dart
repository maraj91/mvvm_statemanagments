import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mvvm_statemanagments/models/movie_search_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesProvider extends ChangeNotifier {
  final List<Search> _favorites = [];
  List<Search> get favorites => _favorites;
  final favoriteKey = "favorites";

  bool isFavorite(Search movie) {
    return _favorites.any((element) => element.imdbID == movie.imdbID);
  }

  void toggleFavorite(Search movie) async {
    if (isFavorite(movie)) {
      removeFavorite(movie);
    } else {
      addFavorite(movie);
    }
    await saveFavorites();
  }

  void addFavorite(Search movie) {
    _favorites.add(movie);
    notifyListeners();
  }

  void removeFavorite(Search movie) {
    _favorites.removeWhere((element) => element.imdbID == movie.imdbID);
    notifyListeners();
  }

  Future<void> saveFavorites() async{
    final prefs = await SharedPreferences.getInstance();
    final stringList = _favorites.map((movie) => json.encode(movie.toJson())).toList();
    await prefs.setStringList(favoriteKey, stringList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final stringList = prefs.getStringList(favoriteKey) ?? [];
    _favorites.clear();
    _favorites.addAll(stringList.map((movie) => Search.fromJson(json.decode(movie))));
    notifyListeners();
  }

  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(favoriteKey);
    _favorites.clear();
    notifyListeners();
  }
}