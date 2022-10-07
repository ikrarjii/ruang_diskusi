import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final String id;
  final String content;
  final String user_id;
  final Timestamp created_at;

  CommentModel({
    required this.id,
    required this.content,
    required this.user_id,
    required this.created_at,
  });

  factory CommentModel.fromJson(Map<String, dynamic>? json) {
    return CommentModel(
      id: json!['id'],
      content: json['content'],
      user_id: json['user_id'],
      created_at: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'user_id': user_id,
        'created_at': created_at,
      };
}
