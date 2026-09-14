import 'package:bloc/bloc.dart';
import 'package:movies_app/api/api_manager.dart';
import 'package:movies_app/ui/screens/browse_tab/cubit/browse_tab_states.dart';

class BrowseTabViewModel extends Cubit<BrowseTabStates> {
  BrowseTabViewModel() : super(BrowseTabLoadingState());

  void getAllMovies() async {
    try {
      emit(BrowseTabLoadingState());
      var response = await ApiManager.getAllMovies();
      if (response.status == "error") {
        emit(BrowseTabErrorState(errorMessage: response.statusMessage!));
      } else {
        emit(BrowseTabSuccessState(moviesResponse: response));
        return;
      }
    } catch (e) {
      print("ERROR = $e");
      emit(BrowseTabErrorState(errorMessage: e.toString()));
    }
  }
}
