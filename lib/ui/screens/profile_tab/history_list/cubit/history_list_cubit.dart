import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../api/api_manager.dart';
import '../../../../../api/models/movie.dart';
import '../../../../../utils/firebase_utils.dart';
import 'history_list_states.dart';

@lazySingleton
class HistoryCubit extends Cubit<HistoryStates> {
  HistoryCubit() : super(HistoryInitialState());

  Future<void> loadHistory() async {
    emit(HistoryLoadingState());

    try {
      final movieIds = await FirebaseUtils.getSavedMoviesIds();

      final movies = await Future.wait(
        movieIds.map((id) => ApiManager.getMovieById(id)),
      );

      emit(HistorySuccessState(moviesList: movies));
    } catch (e) {
      emit(HistoryErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> addToHistory(Movie movie) async {
    try {
      await FirebaseUtils.addMovieToHistoryList(movie);
    } catch (e) {
      emit(HistoryErrorState(errorMessage: e.toString()));
    }
  }
}