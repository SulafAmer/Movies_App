import 'package:movies_app/api/models/movie_datails.dart';

abstract class MovieDetailsStates {}

class MovieDetailsLoadingState extends MovieDetailsStates {}

class MovieDetailsErrorState extends MovieDetailsStates {
  String errorMessage;

  MovieDetailsErrorState({required this.errorMessage});
}

class MovieDetailsSuccessState extends MovieDetailsStates {
  MovieDetails movieDetails;

  MovieDetailsSuccessState({required this.movieDetails});
}
