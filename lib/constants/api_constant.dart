import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {
  static String apiKey = dotenv.env['OMDB_API_KEY']!;
  static String baseUrl = 'https://www.omdbapi.com';
}