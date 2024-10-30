class ChapterModel {
  final String novelTitle; // Tên của truyện
  final String novelImageUrl; // URL hình ảnh của truyện
  final int currentChapter; // Chương hiện tại mà người dùng đang đọc
  final List<String> chapters; // Danh sách các chương

  ChapterModel({
    required this.novelTitle,
    required this.novelImageUrl,
    required this.currentChapter,
    required this.chapters,
  });
}
