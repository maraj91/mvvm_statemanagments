import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:mvvm_statemanagments/constants/api_constant.dart';
import 'package:mvvm_statemanagments/models/movie_details_model.dart';
import 'package:mvvm_statemanagments/models/movie_search_list.dart';

class ApiService {

  final dio = Dio();

  Future<List<Search>> fetchMovies({String search = "batman",int page = 1}) async {
    final url = "${ApiConstant.baseUrl}?s=$search&page=$page&apikey=${ApiConstant.apiKey}";
    final response = await dio.get(url);
    if(response.statusCode == 200){
      final data = response.data;
      return List.from(data["Search"].map((element) => Search.fromJson(element)));
    } else {
      throw Exception("Failed to load data ${response.statusCode}");
    }
  }

  Future<MovieDetailsModel> fetchMovieDetails({required String id}) async {
    final url = "${ApiConstant.baseUrl}?i=$id&apikey=${ApiConstant.apiKey}";
    final response = await dio.get(url);
    if(response.statusCode == 200){
      final data = response.data;
      return MovieDetailsModel.fromJson(data);
    } else {
      throw Exception("Failed to load data ${response.statusCode}");
    }
  }
}