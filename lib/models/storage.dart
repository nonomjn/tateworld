import 'dart:io';

class Storage {
  final String? userId;
  final String? novelId;

  Storage({
    this.userId,
    this.novelId,
  });

  Storage copyWith({
    String? userId,
    String? novelId,
  }) {
    return Storage(
      userId: userId ?? this.userId,
      novelId: novelId ?? this.novelId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': userId,
      'novel': novelId,
    };
  }

  factory Storage.fromJson(Map<String, dynamic> json) {
    return Storage(
      userId: json['user'],
      novelId: json['novel'],
    );
  }
}
