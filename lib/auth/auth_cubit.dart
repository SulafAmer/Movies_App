import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/auth/auth_states.dart';
import 'package:movies_app/utils/firebase_utils.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());
  void login({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      await FirebaseUtils.login(email: email, password: password);
      emit(AuthSuccessState());
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(errorMessage: e.message.toString()));
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }

  void loginWithGoogle() async {
    emit(AuthLoadingState());
    try {
      await FirebaseUtils.loginWithGoogle();
      emit(AuthSuccessState());
    } on GoogleSignInException catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    } catch (e) {
      emit(AuthErrorState(errorMessage: e.toString()));
    }
  }
}
