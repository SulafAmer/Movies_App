import 'package:movies_app/api/models/movie.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<Movie> movies;
  final bool hasReachedMax;
  final bool isLoadingMore;

  SearchSuccess({
    required this.movies,
    required this.hasReachedMax,
    this.isLoadingMore = false,
  });

  SearchSuccess copyWith({
    List<Movie>? movies,
    bool? hasReachedMax,
    bool? isLoadingMore,
  }) {
    return SearchSuccess(
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class SearchEmpty extends SearchState {}

enum SearchErrorType { network, server, unknown }

class SearchError extends SearchState {
  final SearchErrorType type;
  SearchError({this.type = SearchErrorType.unknown});
}
