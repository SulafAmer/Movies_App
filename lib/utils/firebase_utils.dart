import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseUtils {

 static Future<UserCredential> login({
  required String email,
  required String password,
 }) async {
  return await FirebaseAuth.instance
      .signInWithEmailAndPassword(
   email: email,
   password: password,
  );
 }

 static Future<void> logout() async {
  await FirebaseAuth.instance.signOut();
 }
 static Future<UserCredential> loginWithGoogle()async
 {
  final  GoogleSignInAccount? googleUser=await GoogleSignIn.instance.authenticate();
  GoogleSignInAuthentication googleAuth=googleUser!.authentication;
  final credential = GoogleAuthProvider.credential(
   idToken: googleAuth.idToken,
  );

  return await FirebaseAuth.instance.signInWithCredential(credential);
 }
}