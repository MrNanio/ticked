import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future addUserData(
      String name, String surname, String phone, String code) async {
    if (code == "null") {
      try {
        await firebaseFirestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .update({
          "name": name,
          "surname": surname,
          "status": true,
          "phone": phone
        });
      } on FirebaseAuthException catch (e) {
        print(e.toString());
      }
    } else {
      try {
        await firebaseFirestore
            .collection("users")
            .doc(_auth.currentUser!.uid)
            .update({
          "name": name,
          "surname": surname,
          "status": true,
          "role": 'admin',
          "phone": phone
        });
      } on FirebaseAuthException catch (e) {
        print(e.toString());
      }
    }
  }
}
