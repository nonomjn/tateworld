import 'dart:io';

class Novel {
  final String? id;
  final String novelName;
  final String description;
  final File? imageCover;
  final String urlImageCover;

  Novel({
    this.id,
    required this.novelName,
    required this.description,
    this.imageCover,
    this.urlImageCover = '',
  });

  Novel copyWith({
    String? id,
    String? novelName,
    String? description,
    File? imageCover,
    String? urlImageCover,
  }) {
    return Novel(
      id: id ?? this.id,
      novelName: novelName ?? this.novelName,
      description: description ?? this.description,
      imageCover: imageCover ?? this.imageCover,
      urlImageCover: urlImageCover ?? this.urlImageCover,
    );
  }

  bool hasImageCover() {
    return imageCover != null || urlImageCover.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    return {
      'novel_name': novelName,
      'description': description,
    };
  }

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      id: json['id'],
      novelName: json['novel_name'],
      description: json['description'],
      urlImageCover: json['url_image_cover'],
    );
  }
}
