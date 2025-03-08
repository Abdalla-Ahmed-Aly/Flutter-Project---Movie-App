import 'package:dio/dio.dart';
import 'package:movieapp/core/constans.dart';
import 'package:movieapp/features/Movie_details/data/models/Movie_details_model/movie_details_respone.dart';



import 'movie_details_data_source.dart';

class MovieDetailsDataSourceImpl implements MovieDetailsDataSource {
 final Dio _dio=Dio();
  @override
  Future<MovieDetails> getMovieDetails(String movieId)async {

try{
  final response = await _dio.get(ConstansApi.MovieDetails, queryParameters: {"movie_id": movieId});

  if (response.statusCode == 200) {
    final data = response.data;
    return MovieDetails.fromJson(response.data);

  } else {
    throw Exception("Failed to load movies details");
  }
}catch(error){
  throw Exception(error);

}


  }

}