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

  void updateUserData({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    emit(UpdateUserDataLoadingState());
    try {
      await FirebaseUtils.updateUserData(
        name: name,
        phone: phone,
        avatar: avatar,
      );

      currentUser = MyUser(
        id: currentUser?.id ?? '',
        name: name,
        email: currentUser?.email ?? '',
        phone: phone,
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
