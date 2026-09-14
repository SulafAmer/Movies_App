import 'package:movies_app/api/models/all_movies.dart';

abstract class BrowseTabStates {}

class BrowseTabLoadingState extends BrowseTabStates {}

class BrowseTabErrorState extends BrowseTabStates {
  String errorMessage;

  BrowseTabErrorState({required this.errorMessage});
}

class BrowseTabSuccessState extends BrowseTabStates {
  AllMovies moviesResponse;

  BrowseTabSuccessState({required this.moviesResponse});
}
