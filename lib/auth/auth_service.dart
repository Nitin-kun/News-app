import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> loginwithgoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();

      final googleAuth = await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      log('Google Sign-In failed: $e');
      return null;
    }
  }

  Future<User?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return cred.user;
    } catch (e) {
      log("Something went wrong");
    }
    return null;
  }

  Future<void> signout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      log("Something went wrong");
    }
  }
}
