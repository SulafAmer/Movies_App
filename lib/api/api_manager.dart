import 'dart:math';

import 'package:dio/dio.dart';
import 'package:movies_app/api/api_constants.dart';
import 'package:movies_app/api/dio/dio_error_handler.dart';
import 'package:movies_app/api/end_points.dart';
import 'package:movies_app/api/models/all_movies.dart';
import 'package:movies_app/api/models/movie_suggestion.dart';
import 'package:movies_app/api/models/movies_response.dart';
import 'package:movies_app/api/models/movie.dart';
import 'package:movies_app/api/models/movie_datails.dart' as details;

class ApiManager {
  static Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

  static const int searchPageSize = 50;

  ApiManager() {
    // dio.interceptors.add(DioInterceptor());
    // dio.interceptors.add(
    // PrettyDioLogger(
    //   requestHeader: true,
    //   requestBody: true,
    //   responseHeader: false,
    //   responseBody: true,
    //   error: true,
    // ),
    // );
  }

  Future<MoviesResponse> getMoviesList({String? genre, int limit = 10}) async {
    try {
      var response = await dio.get(
        EndPoints.moviesListApi,
        queryParameters: {
          'limit': limit,
          if (genre != null) 'genre': genre,
          'sort_by': 'rating',
          'order_by': 'desc',
        },
      );
      return MoviesResponse.fromJson(response.data);
    } on DioException catch (e) {
      final message = DioErrorHandler.handle(e);
      throw Exception(message);
    }
  }

  Future<MoviesResponse> getRandomMoviesList({int limit = 10}) async {
    final randomPage = Random().nextInt(50) + 1;
    try {
      var response = await dio.get(
        EndPoints.moviesListApi,
        queryParameters: {'limit': limit, 'page': randomPage},
      );
      return MoviesResponse.fromJson(response.data);
    } on DioException catch (e) {
      final message = DioErrorHandler.handle(e);
      throw Exception(message);
    }
  }

  static Future<details.MovieDetails> getMovieDetails({required int id}) async {
    try {
      var response = await dio.get(
        EndPoints.movieDetails,
        queryParameters: {
          "movie_id": id,
          "with_images": true,
          "with_cast": true,
        },
      );

      return details.MovieDetails.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<MovieSuggestion> getMovieSuggestion({required int id}) async {
    try {
      var response = await dio.get(
        EndPoints.movieSuggestion,
        queryParameters: {"movie_id": id},
      );

      return MovieSuggestion.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<AllMovies> getAllMovies() async {
    try {
      var response = await dio.get(
        EndPoints.moviesListApi,
        queryParameters: {"limit": 50},
      );

      return AllMovies.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  static Future<Movie> getMovieById(int id) async {
    final response = await getMovieDetails(id: id);
    final m = response.data!.movie!;

    return Movie(
      id: m.id ?? 0,
      title: m.title ?? '',
      year: m.year ?? 0,
      rating: m.rating ?? 0.0,
      mediumCoverImage: m.mediumCoverImage ?? '',
    );
  }

  static Future<MoviesResponse> searchMovies(String queryQuery, {int page = 1}) async {
    try {
      var response = await dio.get(
        EndPoints.moviesListApi,
        queryParameters: {
          'query_term': queryQuery,
          'limit': searchPageSize,
          'page': page,
          'sort_by': 'rating',
          'order_by': 'desc',
        },
      );
      return MoviesResponse.fromJson(response.data);
    } on DioException catch (e) {
      final message = DioErrorHandler.handle(e);
      throw Exception(message);
    }
  }
}