import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/ui/screens/profile_tab/watch_list/cubit/watch_list_states.dart';

import '../../../../../api/api_manager.dart';
import '../../../../../api/models/movie.dart';
import '../../../../../utils/firebase_utils.dart';

@lazySingleton
class WatchListCubit extends Cubit<WatchListStates> {
  WatchListCubit() : super(WatchListInitialState());

  Future<void> loadWatchList() async {
    emit(WatchListLoadingState());

    try {
      final movieIds = await FirebaseUtils.getFavouriteMovieIds();

      final movies = await Future.wait(
        movieIds.map((id) => ApiManager.getMovieById(id)),
      );

      emit(WatchListSuccessState(moviesList: movies));
    } catch (e) {
      emit(WatchListErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> toggleFavourite(Movie movie) async {
    final currentMovies = state is WatchListSuccessState
        ? (state as WatchListSuccessState).moviesList
        : <Movie>[];

    final isFav = currentMovies.any((m) => m.id == movie.id);

    final updatedMovies = isFav
        ? currentMovies.where((m) => m.id != movie.id).toList()
        : [...currentMovies, movie];

    emit(WatchListSuccessState(moviesList: updatedMovies));

    try {
      await FirebaseUtils.toggleFavourite(movie.id);
    } catch (e) {
      emit(WatchListSuccessState(moviesList: currentMovies));
    }
  }

  bool isFavourite(int movieId) {
    if (state is WatchListSuccessState) {
      return (state as WatchListSuccessState)
          .moviesList
          .any((m) => m.id == movieId);
    }
    return false;
  }
}