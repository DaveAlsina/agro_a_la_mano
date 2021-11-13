import 'dart:developer';

import 'package:agro_a_la_mano_dev/data/repositories/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get uid => _auth.currentUser!.uid.toString();

  // user obj based on firebaseUser
  UserFirebase _userFromFirebase(UserCredential user) {
    return UserFirebase(uid: _auth.currentUser!.uid.toString() );
  }

  // Sign in with email and password
  Future signUpEmailAndPass(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return _userFromFirebase(user);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future registerEmailAndPass(String email, String password) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return _userFromFirebase(user);

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
