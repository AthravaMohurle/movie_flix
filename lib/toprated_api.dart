import 'dart:convert';
import 'package:movie_flixapp/constants.dart';
import 'package:movie_flixapp/movie.dart';
import 'package:http/http.dart'as http;


class topapi{
  static const _topplayingUrl='https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';

  Future<List<Movie>> getTopPlayingMovies() async{
    final response=await http.get(Uri.parse(_topplayingUrl));
    if(response.statusCode==200)
    {
      final decodeData=json.decode(response.body)['results'] as List;
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    }
    else{
      throw Exception('Something happened');
    }


  }
}