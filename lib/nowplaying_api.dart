 import 'dart:convert';


import 'package:movie_flixapp/constants.dart';
import 'package:movie_flixapp/movie.dart';
import 'package:http/http.dart'as http;
class Api{
  static const _nowplayingUrl='https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apiKey}';

  Future<List<Movie>> getNowPlayingMovies() async{
    final response=await http.get(Uri.parse(_nowplayingUrl));
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