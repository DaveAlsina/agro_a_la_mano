import 'package:agro_a_la_mano_dev/data/repositories/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String get uid => _auth.currentUser!.uid.toString();

  // user obj based on firebaseUser
  UserFirebase _userFromFirebase(String uid, String email, String name, String picture)  {
    return UserFirebase(uid: this.uid , email: email, name: name, picture: picture);
  }

  // Sign in with email and password
  Future<UserFirebase?> signUpEmailAndPass(String email, String password) async {
    try {
      UserCredential user = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      print('El usuario del login es ' + user.toString());

      UserFirebase fireUser = _userFromFirebase(user.user!.uid.toString(),
          email, user.additionalUserInfo!.username.toString(), '');

      return fireUser;

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register with email and password
  Future<UserFirebase?> registerEmailAndPass(
      String email, String password, String name) async {
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      var myUser = _auth.currentUser;
      await myUser!.updateDisplayName(name);
      print("This is the current user: " + myUser.toString());
      return _userFromFirebase(user.user!.uid.toString(), email, name, '');
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

