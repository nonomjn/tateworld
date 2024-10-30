class Novel {
  final String title;
  final String author;
  final int chapters;
  final String description;
  final int views;
  final double progress;
  final double rating;
  final String imageUrl;

  Novel({
    required this.title,
    required this.author,
    required this.chapters,
    required this.views,
    required this.progress,
    required this.rating,
    required this.description,
    required this.imageUrl,
  });
}
