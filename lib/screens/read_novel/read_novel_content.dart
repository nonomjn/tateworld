import 'package:flutter/material.dart';

class NovelContent extends StatelessWidget {
  final double fontSize;
  final String selectedFont;
  final ThemeData currentTheme;
  final String novelContent;

  const NovelContent({
    super.key,
    required this.fontSize,
    required this.selectedFont,
    required this.currentTheme,
    required this.novelContent,
  });

  @override
  Widget build(BuildContext context) {
    List<String> paragraphs = novelContent.split('\n');

    return Container(
      color: currentTheme.scaffoldBackgroundColor,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Chapter 1: The Beginning',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: fontSize + 6,
                fontWeight: FontWeight.bold,
                fontFamily: selectedFont,
                color: currentTheme.textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 40),
            // Additional widgets for ratings, views, comments
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    '4.3',
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
                    '1,234',
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
                    '123',
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
            // Novel paragraphs
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
          ],
        ),
      ),
    );
  }
}
