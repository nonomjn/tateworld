import 'dart:io';

class User {
  final String? id;
  final String email;
  final String name;
  final String username;
  final String password;
  final String role;
  final String gender;
  final File? avatar;
  final File? cover;
  final String url_avatar;
  final String url_cover;

  User({
    this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.password,
    required this.role,
    required this.gender,
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
    String? password,
    String? role,
    String? gender,
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
      password: password ?? this.password,
      role: role ?? this.role,
      gender: gender ?? this.gender,
      avatar: avatar ?? this.avatar,
      cover: cover ?? this.cover,
      url_avatar: url_avatar ?? this.url_avatar,
      url_cover: url_cover ?? this.url_cover,
    );
  }

  bool hasAvatar() {
    return avatar != null || url_avatar.isNotEmpty;
  }

  bool hasCover() {
    return cover != null || url_cover.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'username': username,
      'password': password,
      'role': role,
      'gender': gender,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
      password: json['password'],
      role: json['role'],
      gender: json['gender'],
      url_avatar: json['url_avatar'] ?? '',
      url_cover: json['url_cover'] ?? '',
    );
  }
}
