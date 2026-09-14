import 'package:bloc/bloc.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/ui/screens/movie_details/cubit/movie_details_states.dart';

class MovieDetailsViewModel extends Cubit<MovieDetailsStates> {
  MovieDetailsViewModel() : super(MovieDetailsLoadingState());

  void getMovieDetails(int id) async {
    try {
      emit(MovieDetailsLoadingState());
      var response = await ApiManager.getMovieDetails(id: id);
      if (response.status == "error") {
        emit(MovieDetailsErrorState(errorMessage: response.statusMessage!));
      } else {
        emit(MovieDetailsSuccessState(movieDetails: response));
        return;
      }
    } catch (e) {
      emit(MovieDetailsErrorState(errorMessage: e.toString()));
    }
  }
}
