import 'package:movies_app/api/models/my_user.dart';

abstract class UpdateProfileStates {}

class UpdateProfileInitialState extends UpdateProfileStates {}

class GetUserDataLoadingState extends UpdateProfileStates {}

class GetUserDataSuccessState extends UpdateProfileStates {
  final MyUser user;
  GetUserDataSuccessState({required this.user});
}

class GetUserDataErrorState extends UpdateProfileStates {
  final String errorMessage;
  GetUserDataErrorState({required this.errorMessage});
}

class UpdateUserDataLoadingState extends UpdateProfileStates {}

class UpdateUserDataSuccessState extends UpdateProfileStates {}

class UpdateUserDataErrorState extends UpdateProfileStates {
  final String errorMessage;
  UpdateUserDataErrorState({required this.errorMessage});
}

class DeleteAccountLoadingState extends UpdateProfileStates {}

class DeleteAccountSuccessState extends UpdateProfileStates {}

class DeleteAccountErrorState extends UpdateProfileStates {
  final String errorMessage;
  DeleteAccountErrorState({required this.errorMessage});
}
