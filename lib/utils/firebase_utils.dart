import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:movies_app/api/models/my_user.dart';

class FirebaseUtils {
  static Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<UserCredential> loginWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
        .authenticate();
    GoogleSignInAuthentication googleAuth = googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  static Future<MyUser> getCurrentUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('No user is currently logged in');
    }

    final doc = await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(uid)
        .get();

    if (!doc.exists || doc.data() == null) {
      throw Exception('User data not found');
    }

    return MyUser.fromJson(doc.data()!);
  }

  static Future<void> updateUserData({
    required String name,
    required String phone,
    required String avatar,
  }) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('No user is currently logged in');
    }

    await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(uid)
        .update({'name': name, 'phone': phone, 'avatar': avatar});
  }

  static Future<void> deleteAccount() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('No user is currently logged in');
    }

    await FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .doc(uid)
        .delete();

    await FirebaseAuth.instance.currentUser?.delete();
  }

  static Future<void> toggleFavourite(int movieId) async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      throw Exception('No User is Currently logged in ');
    }
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('favourites')
        .doc(movieId.toString());
    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set({'addedAt': FieldValue.serverTimestamp()});
    }
  }

  static  Future<List<int>> getFavouriteMovieIds() async {
   final uid = FirebaseAuth.instance.currentUser?.uid;
   if (uid == null) {
    throw Exception('No user is currently logged in');
   }


   final snapshot = await FirebaseFirestore.instance
       .collection('users')
       .doc(uid)
       .collection('favourites')
       .get();
   return snapshot.docs.map((doc) => int.parse(doc.id)).toList();

  }

}
