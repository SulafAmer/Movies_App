import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/api/models/my_user.dart';
import 'package:movies_app/ui/screens/profile/cubit/update_profile_states.dart';
import 'package:movies_app/utils/firebase_utils.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileStates> {
  UpdateProfileCubit() : super(UpdateProfileInitialState());

  MyUser? currentUser;

  void getUserData() async {
    emit(GetUserDataLoadingState());
    try {
      final user = await FirebaseUtils.getCurrentUserData();
      currentUser = user;
      emit(GetUserDataSuccessState(user: user));
    } catch (e) {
      emit(GetUserDataErrorState(errorMessage: e.toString()));
    }
  }

  String? validateName(String? name) {
    final trimmed = (name ?? '').trim();
    if (trimmed.isEmpty) {
      return 'Name cannot be empty';
    }
    if (trimmed.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  String? validatePhone(String? phone) {
    final trimmed = (phone ?? '').trim();
    if (trimmed.isEmpty) {
      return 'Phone number cannot be empty';
    }
    final egyptianPhoneRegex = RegExp(r'^01[0125][0-9]{8}$');
    if (!egyptianPhoneRegex.hasMatch(trimmed)) {
      return 'Enter a valid phone number (e.g. 01xxxxxxxxx)';
    }
    return null;
  }

  void updateUserData({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    if (currentUser == null) {
      emit(UpdateUserDataErrorState(errorMessage: 'User data not loaded yet'));
      return;
    }

    final nameError = validateName(name);
    if (nameError != null) {
      emit(UpdateUserDataErrorState(errorMessage: nameError));
      return;
    }

    final phoneError = validatePhone(phone);
    if (phoneError != null) {
      emit(UpdateUserDataErrorState(errorMessage: phoneError));
      return;
    }

    emit(UpdateUserDataLoadingState());
    try {
      final trimmedName = name.trim();
      final trimmedPhone = phone.trim();

      await FirebaseUtils.updateUserData(
        name: trimmedName,
        phone: trimmedPhone,
        avatar: avatar,
      );

      currentUser = MyUser(
        id: currentUser!.id,
        name: trimmedName,
        email: currentUser!.email,
        phone: trimmedPhone,
        avatar: avatar,
      );
      emit(UpdateUserDataSuccessState());
    } catch (e) {
      emit(UpdateUserDataErrorState(errorMessage: e.toString()));
    }
  }

  void deleteAccount() async {
    emit(DeleteAccountLoadingState());
    try {
      await FirebaseUtils.deleteAccount();
      emit(DeleteAccountSuccessState());
    } catch (e) {
      emit(DeleteAccountErrorState(errorMessage: e.toString()));
    }
  }
}
