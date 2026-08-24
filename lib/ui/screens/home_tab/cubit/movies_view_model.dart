import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/dio/dio_error_handler.dart';
import 'package:movies_app/ui/screens/home_tab/cubit/movies_states.dart';

class MoviesViewModel extends Cubit<MoviesStates> {
  MoviesViewModel() : super(MovieLoadingState());
  //hold data - handle logic
  void getMovies() async {
    //todo:loading
    try {
      //todo:loading
      emit(MovieLoadingState());
      //todo:call api
      final results = await Future.wait([
        ApiManager().getMoviesList(genre: 'Drama'),
        ApiManager().getMoviesList(genre: 'Family'),
        ApiManager().getRandomMoviesList(),
      ]);
      final dramaMoviesResponse = results[0];
      final familyMoviesResponse = results[1];
      final randomMoviesResponse = results[2];
      final allResponses = [
        dramaMoviesResponse,
        familyMoviesResponse,
        randomMoviesResponse,
      ];
      if (allResponses.every((element) => element.status == 'ok')) {
        emit(
          MovieSuccessState(
            availableNowMovies: randomMoviesResponse.movies,
            genre1Movies: familyMoviesResponse.movies,
            genre2Movies: dramaMoviesResponse.movies,
          ),
        );
      } else {
        final failedResponse = allResponses.firstWhere(
          (element) => element.status != 'ok',orElse: () => dramaMoviesResponse,
        );
        emit(
          MovieErrorState(
            errorMessage: failedResponse.statusMessage.isEmpty
                ? failedResponse.statusMessage
                : 'An unexpected error occurred during loading data ',
          ),
        );
      }
    } on DioException catch (e) {
      emit(MovieErrorState(errorMessage: DioErrorHandler.handle(e)));
    }
  }
}
