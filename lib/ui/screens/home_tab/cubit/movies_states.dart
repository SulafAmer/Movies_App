import 'package:movies_app/api/models/movies.dart';

abstract class MoviesStates {}
class MovieLoadingState extends MoviesStates{}
class MovieErrorState extends MoviesStates{
  final String errorMessage;
  MovieErrorState({required this.errorMessage});
}
class MovieSuccessState extends MoviesStates{
  final List<Movie>availableNowMovies;
  final List <Movie>dramaMovies;
  final List <Movie>familyMovies;

  MovieSuccessState({
    required this.availableNowMovies,
    required this.dramaMovies,
    required this.familyMovies
  });
}


