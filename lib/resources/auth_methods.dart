import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_chat_app/data/user_data.dart';

class AuthMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserData> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot documentSnapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return UserData.fromSnap(documentSnapshot);
  }

  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty) {
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        UserData _user = UserData(
          username: username,
          uid: cred.user!.uid,
          email: email,
        );

        await _firestore
            .collection("users")
            .doc(cred.user!.uid)
            .set(_user.toJson());

        res = "success";
      } else {
        res = "すべての項目を入力してください";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "すべての項目を入力してください";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
