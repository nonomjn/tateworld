import 'package:flutter/material.dart';

import '../novels/novels_manager.dart';
import '../novels/novel_detail_screen.dart';
import '../../models/novel.dart';

class ReadingTab extends StatelessWidget {
  const ReadingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final novels = NovelsManager().getNovels();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Số cột
            childAspectRatio: 0.41, // Tỉ lệ chiều rộng so với chiều cao
            crossAxisSpacing: 4.0, // Khoảng cách giữa các cột
            mainAxisSpacing: 10, // Khoảng cách giữa các hàng
          ),
          itemCount: novels.length,
          itemBuilder: (context, index) {
            return _buildNovelCard(context: context, novel: novels[index]);
          },
        ),
      ),
    );
  }

  Widget _buildNovelCard({
    required BuildContext context,
    required Novel novel,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NovelDetailScreen(novel: novel),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                novel.imageUrl,
                fit: BoxFit.cover,
                height: 200,
                width: 140,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: LinearProgressIndicator(
                value: novel.progress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              novel.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${novel.rating}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.menu_book,
                      color: Colors.grey,
                      size: 16,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${novel.chapters}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
