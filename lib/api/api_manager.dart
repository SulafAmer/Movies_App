import 'dart:math';

import 'package:dio/dio.dart';
import 'package:movies_app/api/api_constants.dart';
import 'package:movies_app/api/dio/dio_error_handler.dart';
import 'package:movies_app/api/dio/dio_interceptor.dart';
import 'package:movies_app/api/end_points.dart';
import 'package:movies_app/api/models/movies_response.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiManager {
  //todo:dio implementation
  Dio dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  //todo: INTERCEPTOR
  ApiManager() {
    dio.interceptors.add(DioInterceptor());
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
      ),
    );
  }
  Future<MoviesResponse> getMoviesList({String? genre , int limit=10}) async {
    try {
      var response = await dio.get(
        EndPoints.moviesListApi,
        queryParameters: {
          'limit': limit,
          if (genre != null)'genre':genre,
          'sort_by': 'rating',
          'order_by': 'desc'},
      );
      return MoviesResponse.fromJson(response.data);
    } on DioException catch (e) {
      final message = DioErrorHandler.handle(e);
      throw Exception(message);
    }
  }
  Future<MoviesResponse> getRandomMoviesList({ int limit=10}) async {
    final randomPage=Random().nextInt(50)+1;
    try {
      var response = await dio.get(
        EndPoints.moviesListApi,
        queryParameters: {
          'limit': limit,
          'page':randomPage,
        },
      );
      return MoviesResponse.fromJson(response.data);
    } on DioException catch (e) {
      final message = DioErrorHandler.handle(e);
      throw Exception(message);
    }
  }
}
