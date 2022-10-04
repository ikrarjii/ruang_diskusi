import 'package:cloud_firestore/cloud_firestore.dart';

class DiscussionModel {
  final String id;
  final String title;
  final String description;
  final String keyword;
  final String user;
  final Timestamp created_at;

  DiscussionModel({
    required this.id,
    required this.title,
    required this.description,
    required this.keyword,
    required this.user,
    required this.created_at,
  });

  factory DiscussionModel.fromJson(Map<String, dynamic>? json) {
    return DiscussionModel(
      id: json!['id'],
      title: json['title'],
      description: json['description'],
      keyword: json['keyword'],
      user: json['user'],
      created_at: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'keyword': keyword,
        'user': user,
        'created_at': created_at,
      };
}
