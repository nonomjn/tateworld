import 'package:flutter/material.dart';
import '../../models/chapter.dart';

class NovelContent extends StatelessWidget {
  final double fontSize;
  final String selectedFont;
  final ThemeData currentTheme;
  final Chapter chapter;
  final ScrollController scrollController;

  const NovelContent({
    super.key,
    required this.fontSize,
    required this.selectedFont,
    required this.currentTheme,
    required this.chapter,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    // Tách nội dung chương thành các đoạn văn
    List<String> paragraphs = chapter.content.split('\n');

    return Container(
      color: currentTheme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Hiển thị tiêu đề chương
            Text(
              chapter.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize + 6,
                fontWeight: FontWeight.bold,
                fontFamily: selectedFont,
                color: currentTheme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 20),
            // Hiển thị biểu tượng lượt xem, bình chọn, và bình luận
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '4.3', // Rating hiện tại
                    style: TextStyle(
                      fontSize: fontSize - 2,
                      fontWeight: FontWeight.bold,
                      fontFamily: selectedFont,
                      color: currentTheme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.remove_red_eye,
                      color: Colors.grey, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    chapter.count_view.toString(),
                    style: TextStyle(
                      fontSize: fontSize - 2,
                      fontFamily: selectedFont,
                      color: currentTheme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Icon(Icons.comment, color: Colors.grey, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '123', // Số bình luận tĩnh hoặc động khi có dữ liệu
                    style: TextStyle(
                      fontSize: fontSize - 2,
                      fontFamily: selectedFont,
                      color: currentTheme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            // Nội dung chương
            ...paragraphs.map((paragraph) {
              if (paragraph.trim().isEmpty) return const SizedBox.shrink();
              return Column(
                children: [
                  Text(
                    paragraph.trim(),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontFamily: selectedFont,
                      height: 1.5,
                      color: currentTheme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            }),
            // Khoảng cách dưới cùng để dễ đọc khi cuộn tới cuối
            SizedBox(height: MediaQuery.of(context).size.height / 2),
          ],
        ),
      ),
    );
  }
}
