import 'package:movies_app/api/models/movie_datails.dart';
import 'package:movies_app/api/models/movie_suggestion.dart';

abstract class MovieSuggestionStates {}

class MovieSuggestionLoadingState extends MovieSuggestionStates {}

class MovieSuggestionErrorState extends MovieSuggestionStates {
  String errorMessage;

  MovieSuggestionErrorState({required this.errorMessage});
}

class MovieSuggestionSuccessState extends MovieSuggestionStates {
  MovieSuggestion movieSuggestion;

  MovieSuggestionSuccessState({required this.movieSuggestion});
}
