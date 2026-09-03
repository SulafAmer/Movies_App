import '../../../../../api/models/movie.dart';

abstract class HistoryStates {}

class HistoryInitialState extends HistoryStates {}

class HistorySuccessState extends HistoryStates {
  List<Movie> moviesList;

  HistorySuccessState({
    required this.moviesList,
  });
}

class HistoryErrorState extends HistoryStates {
  String errorMessage;

  HistoryErrorState({
    required this.errorMessage,
  });
}

class HistoryLoadingState extends HistoryStates {}