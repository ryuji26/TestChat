import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String email;
  final String uid;
  final String username;

  const UserData({
    required this.username,
    required this.uid,
    required this.email,
  });

  static UserData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserData(
      username: snapshot["username"],
      uid: snapshot["uid"],
      email: snapshot["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "email": email,
      };
}
