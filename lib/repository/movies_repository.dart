import 'package:mvvm_statemanagments/models/movie_details_model.dart';
import 'package:mvvm_statemanagments/models/movie_search_list.dart';
import 'package:mvvm_statemanagments/services/api_service.dart';

class MoviesRepository {
  final ApiService _apiService;

  MoviesRepository(this._apiService);

  Future<List<Search>> fetchMovies({String search = "batman",int page = 1}) async {
    final result = await _apiService.fetchMovies(search: search, page: page);
    return result;
  }

  Future<MovieDetailsModel> fetchMovieDetails({required String id}) async {
    final result = await _apiService.fetchMovieDetails(id: id);
    return result;
  }
}