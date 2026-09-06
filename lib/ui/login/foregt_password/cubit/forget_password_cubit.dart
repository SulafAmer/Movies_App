import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'forget_password_states.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ForgotPasswordCubit() : super(ForgotPasswordInitial());

  Future<void> sendPasswordResetEmail(String email) async {
    if (email.trim().isEmpty) {
      emit(ForgotPasswordError('Please enter your email address'));
      return;
    }

    emit(ForgotPasswordLoading());
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      emit(ForgotPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(ForgotPasswordError('No user found with this email.'));
      } else if (e.code == 'invalid-email') {
        emit(ForgotPasswordError('The email address is badly formatted.'));
      } else {
        emit(ForgotPasswordError(e.message ?? 'An error occurred.'));
      }
    } catch (e) {
      emit(ForgotPasswordError(e.toString()));
    }
  }
}
