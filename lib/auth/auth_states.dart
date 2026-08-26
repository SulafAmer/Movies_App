abstract class AuthStates {
}
class AuthInitialState extends AuthStates{}
class AuthLoadingState extends AuthStates{}
class AuthErrorState extends AuthStates{
  final String errorMessage;
  AuthErrorState({required this.errorMessage});
}
class AuthSuccessState extends AuthStates{}