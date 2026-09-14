import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/api/models/movie.dart';
import 'search_states.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  static const int _pageSize = ApiManager.searchPageSize;

  Timer? _debounce;
  String _currentQuery = '';
  int _currentPage = 1;
  bool _isFetching = false;
  final List<Movie> _movies = [];

  void searchMovies(String query) {
    _debounce?.cancel();
    final trimmed = query.trim();

    if (trimmed.isEmpty) {
      _currentQuery = '';
      _movies.clear();
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());

    _debounce = Timer(
      const Duration(milliseconds: 400),
      () => _startNewSearch(trimmed),
    );
  }

  Future<void> _startNewSearch(String query) async {
    _currentQuery = query;
    _currentPage = 1;
    _movies.clear();
    _isFetching = true;

    try {
      final response = await ApiManager.searchMovies(query, page: _currentPage);

      if (_currentQuery != query) return;

      if (!response.isOk) {
        emit(SearchError(type: SearchErrorType.server));
        return;
      }

      _movies.addAll(_filterByTitle(response.movies, query));
      final hasReachedMax = response.movies.length < _pageSize;

      if (_movies.isEmpty) {
        emit(SearchEmpty());
      } else {
        emit(
          SearchSuccess(movies: List.of(_movies), hasReachedMax: hasReachedMax),
        );
      }
    } on DioException catch (e) {
      if (_currentQuery != query) return;
      final isNetwork =
          e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout;
      emit(
        SearchError(
          type: isNetwork ? SearchErrorType.network : SearchErrorType.server,
        ),
      );
    } catch (e) {
      if (_currentQuery != query) return;
      emit(SearchError(type: SearchErrorType.unknown));
    } finally {
      _isFetching = false;
    }
  }

  Future<void> loadMore() async {
    final currentState = state;
    if (currentState is! SearchSuccess) return;
    if (currentState.hasReachedMax || currentState.isLoadingMore) return;
    if (_isFetching) return;

    _isFetching = true;
    emit(currentState.copyWith(isLoadingMore: true));

    _currentPage++;

    try {
      final response = await ApiManager.searchMovies(
        _currentQuery,
        page: _currentPage,
      );
      _movies.addAll(_filterByTitle(response.movies, _currentQuery));
      final hasReachedMax = response.movies.length < _pageSize;

      emit(
        SearchSuccess(
          movies: List.of(_movies),
          hasReachedMax: hasReachedMax,
          isLoadingMore: false,
        ),
      );
    } catch (_) {
      _currentPage--;
      emit(currentState.copyWith(isLoadingMore: false));
    } finally {
      _isFetching = false;
    }
  }

  List<Movie> _filterByTitle(List<Movie> movies, String query) {
    final q = query.toLowerCase();
    return movies.where((m) => m.title.toLowerCase().contains(q)).toList();
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}
