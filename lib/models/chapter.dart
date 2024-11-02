import 'dart:io';

class Chapter {
  final String? id;
  final String title;
  final String content;
  final int count_view;
  final String status;

  Chapter({
    this.id,
    required this.title,
    required this.content,
    required this.count_view,
    required this.status,
  });

  Chapter copyWith({
    String? id,
    String? title,
    String? content,
    int? count_view,
    String? status,
  }) {
    return Chapter(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      count_view: count_view ?? this.count_view,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'count_view': count_view,
      'status': status,
    };
  }

  factory Chapter.fromJson(Map<String, dynamic> json) {
    return Chapter(
      id: json['id'] as String?,
      title: json['title'] as String,
      content: json['content'] as String,
      count_view: json['count_view'] as int,
      status: json['status'] as String,
    );
  }
}
