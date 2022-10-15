import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel {
  final dynamic id;
  final String content;
  final String user_id;
  final bool is_the_best;
  final Timestamp created_at;

  CommentModel({
    required this.id,
    required this.content,
    required this.user_id,
    required this.is_the_best,
    required this.created_at,
  });

  factory CommentModel.fromJson(Map<String, dynamic>? json) {
    return CommentModel(
      id: json!['id'],
      content: json['content'],
      user_id: json['user_id'],
      is_the_best: json['is_the_best'] ?? false,
      created_at: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'user_id': user_id,
        'is_the_best': is_the_best,
        'created_at': created_at,
      };
}
