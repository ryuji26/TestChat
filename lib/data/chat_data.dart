import 'package:cloud_firestore/cloud_firestore.dart';

class ChatData {
  final String chatText;
  final String uid;
  final String username;
  final String postId;
  final DateTime datePublished;
  final String postUrl;

  const ChatData({
    required this.chatText,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postUrl,
  });

  static ChatData fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ChatData(
      chatText: snapshot["description"],
      uid: snapshot["uid"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
      username: snapshot["username"],
      postUrl: snapshot['postUrl'],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": chatText,
        "uid": uid,
        "username": username,
        "postId": postId,
        "datePublished": datePublished,
        'postUrl': postUrl,
      };
}
