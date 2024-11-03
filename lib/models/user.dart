import 'dart:io';

class User {
  final String? id;
  final String email;
  final String name;
  final String username;
  final String role;
  final String gender;
  final String? introduce;
  final File? avatar;
  final File? cover;
  final String? url_avatar;
  final String? url_cover;

  User({
    this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.role,
    required this.gender,
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
      introduce: introduce ?? this.introduce,
      avatar: avatar ?? this.avatar,
      cover: cover ?? this.cover,
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
      'id': id,
      'email': email,
      'name': name,
      'username': username,
      'introduce': introduce,
      'role': role,
      'gender': gender,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    try {
      User user = User(
        id: json['id'],
        email: json['email'],
        name: json['name'] ,
        username: json['username'],
        role: json['role'],
        gender: json['gender'],
        introduce: json['introduce'] ?? '',
        url_avatar: json['url_avatar'] ?? '',
        url_cover: json['url_cover'] ?? '',
      );
      String toStringurl_avatar = user.url_avatar.toString();
      String toStringurl_cover = user.url_cover.toString();
      print('url_avatar: $toStringurl_avatar');
      return user;
    } catch (e) {
      print( 'Error parsing User from JSON: $e');
      return User(
          id: '',
          email: '',
          name: '',
          username: '',
          role: '',
          gender: '');
    }
  }
}
