import 'package:flutter/cupertino.dart';
import 'package:mvvm_statemanagments/models/movie_details_model.dart';
import 'package:mvvm_statemanagments/models/movie_search_list.dart';
import 'package:mvvm_statemanagments/repository/movies_repository.dart';
import 'package:mvvm_statemanagments/services/init_getit.dart';

class MoviesProvider extends ChangeNotifier {
  int _currentPage = 1;
  final List<Search> _movies = [];
  List<Search> get movies => _movies;

  MovieDetailsModel _movieDetails = MovieDetailsModel();
  MovieDetailsModel get movieDetails => _movieDetails;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _error = '';
  String get error => _error;

  final MoviesRepository _moviesRepository = getIt<MoviesRepository>();

  Future<void> fetchMovies() async {
    _isLoading = true;
    notifyListeners();
    try {
      final result = await _moviesRepository.fetchMovies(page: _currentPage);
      _movies.addAll(result);
      _isLoading = false;
      _currentPage++;
      _error = '';
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchMovieDetails(String imdbID) async {
    _isLoading = true;
    notifyListeners();
    try {
      _movieDetails = await _moviesRepository.fetchMovieDetails(id: imdbID);
      _isLoading = false;
      _currentPage++;
      _error = '';
    } catch (e) {
      _error = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}