import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String description;
  final String postId;
  final DateTime datePublished;

  const Post({
    required this.description,
    required this.postId,
    required this.datePublished,
  });

  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return Post(
      description: snapshot["description"],
      postId: snapshot["postId"],
      datePublished: snapshot["datePublished"],
    );
  }

  Map<String, dynamic> toJson() => {
        "description": description,
        "postId": postId,
        "datePublished": datePublished,
      };
}
