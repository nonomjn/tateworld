import 'dart:io';

class Novel {
  final String? id;
  final String novelName;
  final String description;
  final bool isCompleted;
  final String author;
  final File? imageCover;
  final String urlImageCover;
  final File? imageAuthAvatar = null;
  final String? urlAuthAvatar = '';
  final int? totalChaptersPublished;
  final int? totalChaptersDraft;
  final int? totalViews;

  Novel({
    this.id,
    required this.novelName,
    required this.description,
    this.isCompleted = false,
    required this.author,
    this.imageCover,
    this.urlImageCover = '',
    this.totalChaptersPublished,
    this.totalChaptersDraft,
    this.totalViews,
  });

  Novel copyWith({
    String? id,
    String? novelName,
    String? description,
    bool? isCompleted,
    String? author,
    File? imageCover,
    String? urlImageCover,
    int? totalChaptersPublished,
    int? totalChaptersDraft,
    int? totalViews,
  }) {
    return Novel(
      id: id ?? this.id,
      novelName: novelName ?? this.novelName,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      author: author ?? this.author,
      imageCover: imageCover ?? this.imageCover,
      urlImageCover: urlImageCover ?? this.urlImageCover,
      totalChaptersPublished:
          totalChaptersPublished ?? this.totalChaptersPublished,
      totalChaptersDraft: totalChaptersDraft ?? this.totalChaptersDraft,
      totalViews: totalViews ?? this.totalViews,
    );
  }

  bool hasImageCover() {
    return imageCover != null || urlImageCover.isNotEmpty;
  }

  bool hasAuthAvatar() {
    return imageAuthAvatar != null || urlAuthAvatar!.isNotEmpty;
  }
  Map<String, dynamic> toJson() {
    return {
      'novel_name': novelName,
      'description': description,
      'is_completed': isCompleted,
      'author': author,
    };
  }

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      id: json['id'],
      novelName: json['novel_name'],
      description: json['description'],
      isCompleted: json['is_completed'],
      author: json['author'],
      urlImageCover: json['image_cover'],
      totalChaptersPublished: json['totalChaptersPublished'] ?? 0,
      totalChaptersDraft: json['totalChaptersDraft'] ?? 0,
      totalViews: json['totalViews'] ?? 0,
    );
  }
}
