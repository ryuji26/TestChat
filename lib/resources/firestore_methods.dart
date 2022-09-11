import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_chat_app/data/room_data.dart';
import 'package:uuid/uuid.dart';

class FireStoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadRoom(String roomName) async {
    String res = "エラーが発生しました";
    try {
      String roomId = const Uuid().v1();
      ChatRoom post = ChatRoom(
        roomName: roomName,
        roomId: roomId,
        datePublished: DateTime.now(),
      );
      _firestore.collection('rooms').doc(roomId).set(post.toJson());
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> postComment(String roomId, String text, String uid,
      String name, String profilePic) async {
    String res = "エラーが発生しました";
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        _firestore
            .collection('rooms')
            .doc(roomId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });
        res = 'success';
      } else {
        res = "コメントを入力してください";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<String> deletePost(String roomId) async {
    String res = "Some error occurred";
    try {
      await _firestore.collection('rooms').doc(roomId).delete();
      res = 'success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
