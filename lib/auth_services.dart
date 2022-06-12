import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  // static Future<User> signInAnonymous() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

  // static Future<User> signUp(String email, String password) async {
  //   try {
  //     UserCredential result = await _auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     User? firebaseUser = result.user;
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  static Future<void> signOut() async {
    _auth.signOut();
  }

  static Stream<User?> Function() get firebaseUserStream =>
      _auth.authStateChanges;
}
