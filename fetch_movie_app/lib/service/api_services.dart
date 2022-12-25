import 'package:dio/dio.dart';
import 'package:fetch_movie_app/model/movie.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final Dio _dio = Dio();



  Future<List<Movie>> getMovie(String text) async {
    try{
      final apiKey = dotenv.env['API_KEY'].toString();
      final response = await _dio.get('https://api.themoviedb.org/3/movie/$text?api_key=$apiKey&language=en-US');
      var movies = response.data['results'] as List;
      List<Movie> movieList = movies.map((m) => Movie.fromJson(m)).toList();
      return movieList;
    } catch (error,stacktrace){
      throw Exception(
        'Excerption accoured $error with stacktrace: $stacktrace'
      );
    }
  }
}