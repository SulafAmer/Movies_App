import 'package:movies_app/api/models/movies.dart';

abstract class MoviesStates {}
class MovieLoadingState extends MoviesStates{}
class MovieErrorState extends MoviesStates{
  final String errorMessage;
  MovieErrorState({required this.errorMessage});
}
class MovieSuccessState extends MoviesStates{
  final List<Movie>availableNowMovies;
  final List <Movie>genre1Movies;
  final List <Movie>genre2Movies;

  MovieSuccessState({
    required this.availableNowMovies,
    required this.genre1Movies,
    required this.genre2Movies
  });
}


