import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/api/models/my_user.dart';
import 'package:movies_app/ui/screens/profile_tab/profile_screen/cubit/profile_states.dart';
@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfileCubit() : super(ProfileInitial());

  Future<void> loadUserProfile(String userId) async {
    if (userId.isEmpty) {
      emit(ProfileError('User not logged in'));
      return;
    }

    emit(ProfileLoading());
    try {
      DocumentSnapshot doc = await _firestore.collection('Users').doc(userId).get();
      if (doc.exists) {
        MyUser user = MyUser.fromJson(doc.data() as Map<String, dynamic> );
        emit(ProfileLoaded(user));
      } else {
        emit(ProfileError('User data not found'));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
