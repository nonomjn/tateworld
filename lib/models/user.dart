import 'dart:io';
import '../screens/util/helper.dart';

class User {
  late String? id;
  late String email;
  late String name;
  late String username;
  late String role;
  late String gender;
  late String? introduce;
  late DateTime DoB;
  late File? avatar;
  late File? cover;
  late String? url_avatar;
  late String? url_cover;

  User({
    this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.role,
    required this.gender,
    required this.DoB,
    this.introduce,
    this.avatar,
    this.cover,
    this.url_avatar = '',
    this.url_cover = '',
  });

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? username,
    String? introduce,
    String? role,
    String? gender,
    DateTime? DoB,
    File? avatar,
    File? cover,
    String? url_avatar,
    String? url_cover,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      username: username ?? this.username,
      role: role ?? this.role,
      gender: gender ?? this.gender,
      DoB: DoB ?? this.DoB,
      introduce: introduce ?? this.introduce,
      cover: cover ?? this.cover,
      avatar: avatar ?? this.avatar,
      url_avatar: url_avatar ?? this.url_avatar,
      url_cover: url_cover ?? this.url_cover,
    );
  }

  bool hasAvatar() {
    return avatar != null || (url_avatar?.isNotEmpty ?? false);
  }

  bool hasCover() {
    return cover != null || (url_cover?.isNotEmpty ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'username': username,
      'introduce': introduce,
      'role': role,
      'gender': gender,
      'DoB': formatDateTimeForPocketBase(DoB),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      return User(
        id: json['id'] ?? '',
        email: json['email'] ?? '',
        name: json['name'] ?? '',
        username: json['username'] ?? '',
        role: json['role'] ?? '',
        gender: json['gender'] ?? '',
        DoB: DateTime.parse(json['DoB']),
        introduce: json['introduce'] ?? '',
        url_avatar: json['url_avatar'] ?? '',
        url_cover: json['url_cover'] ?? '',
      );
    } catch (e) {
      return User(
          id: '',
          email: '',
          name: '',
          username: '',
          role: '',
          gender: '',
          DoB: DateTime.now());
    }
  }
}
