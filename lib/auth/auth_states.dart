abstract class AuthStates {}

class AuthInitialState extends AuthStates {}

class AuthLoadingState extends AuthStates {}

class AuthErrorState extends AuthStates {
  final String errorMessage;
  AuthErrorState({required this.errorMessage});
}

class AuthSuccessState extends AuthStates {}

class RegisterLoadingState extends AuthStates {}

class RegisterErrorState extends AuthStates {
  final String errorCode;
  RegisterErrorState({required this.errorCode});
}

class RegisterSuccessState extends AuthStates {}
