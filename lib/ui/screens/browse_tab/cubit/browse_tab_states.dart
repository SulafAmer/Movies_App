import 'package:movies_app/api/models/browse_model.dart';

abstract class BrowseTabStates {}

class BrowseTabLoadingState extends BrowseTabStates {}

class BrowseTabErrorState extends BrowseTabStates {
  String errorMessage;

  BrowseTabErrorState({required this.errorMessage});
}

class BrowseTabSuccessState extends BrowseTabStates {
  BrowseModel browseResponse;

  BrowseTabSuccessState({required this.browseResponse});
}
