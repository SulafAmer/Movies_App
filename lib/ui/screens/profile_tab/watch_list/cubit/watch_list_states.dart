import '../../../../../api/models/movie.dart';

abstract class WatchListStates {}

class WatchListInitialState extends WatchListStates {}

class WatchListSuccessState extends WatchListStates {
  List<Movie> moviesList;
  WatchListSuccessState({required this.moviesList});
}

class WatchListErrorState extends WatchListStates {
  String errorMessage;
  WatchListErrorState({required this.errorMessage});
}

class WatchListLoadingState extends WatchListStates {}