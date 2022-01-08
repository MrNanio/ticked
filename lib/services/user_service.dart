import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final CollectionReference airlinesCollection =
      FirebaseFirestore.instance.collection('airlines');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  Future addUserData(
      String name, String surname, String phone, String code) async {
    var snapshot =
        await airlinesCollection.where('code', isEqualTo: code).get();

    if (snapshot.size == 0) {
      code = "null";
    }
    if (code == "null") {
      try {
        await usersCollection.doc(_auth.currentUser!.uid).update({
          "name": name,
          "surname": surname,
          "status": true,
          "phone": phone,
          "airline_code": code
        });
      } on FirebaseAuthException catch (e) {
        print(e.toString());
      }
    } else {
      try {
        await usersCollection.doc(_auth.currentUser!.uid).update({
          "name": name,
          "surname": surname,
          "status": true,
          "role": 'admin',
          "phone": phone,
          "airline_code": code
        });
      } on FirebaseAuthException catch (e) {
        print(e.toString());
      }
    }
  }
}
