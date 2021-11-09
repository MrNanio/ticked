import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ticked/models/custom_user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<CustomUser?> _userFromFirebaseUser(User? user) async {
    return user != null
        ? await userCollection.doc(uid).get().then(
            (value) => CustomUser.fromMap(value.data() as Map<String, dynamic>))
        : null;
  }

  String? get uid {
    return _auth.currentUser?.uid;
  }

  Stream<CustomUser?> get customUser {
    return _auth.authStateChanges().asyncMap(_userFromFirebaseUser);
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'Niepoprawne dane.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Niepoprawne dane.';
      }
      return errorMessage;
    }
  }

  Future registerWithEmailAndPassword(
      String email, String password, String confirmPassword) async {
    if (password != confirmPassword) {
      return 'Hasła różnią się.';
    }
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      CustomUser customUser = CustomUser(
          uid: user!.uid, email: user.email, status: false, role: 'user');

      await userCollection.doc(user.uid).set(customUser.toMap());
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      switch (e.code) {
        case "email-already-in-use":
          errorMessage = "Adres email jest zajęty.";
          break;
        default:
          errorMessage = "Error occured.";
      }
      return errorMessage;
    }
  }

  Future resetPasswordFromEmail(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
