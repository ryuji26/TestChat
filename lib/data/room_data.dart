import 'package:cloud_firestore/cloud_firestore.dart';

class ChatRoom {
  final String roomName;
  final String roomId;
  final DateTime datePublished;

  const ChatRoom({
    required this.roomName,
    required this.roomId,
    required this.datePublished,
  });

  static ChatRoom fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return ChatRoom(
      roomName: snapshot["roomName"],
      roomId: snapshot["roomId"],
      datePublished: snapshot["datePublished"],
    );
  }

  Map<String, dynamic> toJson() => {
        "roomName": roomName,
        "roomId": roomId,
        "datePublished": datePublished,
      };
}
