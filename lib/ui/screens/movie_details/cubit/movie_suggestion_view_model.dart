import 'package:bloc/bloc.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/ui/screens/movie_details/cubit/movie_details_states.dart';
import 'package:movies_app/ui/screens/movie_details/cubit/movie_suggestion_states.dart';

class MovieSuggestionViewModel extends Cubit<MovieSuggestionStates> {
  MovieSuggestionViewModel() : super(MovieSuggestionLoadingState());

  void getMovieSuggestions(int id) async {
    try {
      emit(MovieSuggestionLoadingState());
      var response = await ApiManager.getMovieSuggestion(id: id);
      if (response.status == "error") {
        emit(MovieSuggestionErrorState(errorMessage: response.statusMessage!));
      } else {
        emit(MovieSuggestionSuccessState(movieSuggestion: response));
        return;
      }
    } catch (e) {
      emit(MovieSuggestionErrorState(errorMessage: e.toString()));
    }
  }
}
