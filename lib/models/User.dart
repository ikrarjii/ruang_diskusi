import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final dynamic id;
  final String email;
  final String name;
  final int point;
  final String role;
  final String spesialis;
  final String RS;
  final String image;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.point,
    required this.role,
    required this.spesialis,
    required this.RS,
    required this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic>? json) {
    return UserModel(
      id: json!['id'],
      email: json['email'],
      name: json['name'],
      point: json['point'],
      role: json['role'],
      spesialis: json['spesialis'],
      RS: json['RS'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'point': point,
        'role': role,
        'spesialis': spesialis,
        'RS': RS,
        'image': image,
      };
}
