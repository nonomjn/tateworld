import 'package:flutter/material.dart';
import '../../models/novel.dart';
import 'novel_detail_screen.dart';
import '../util/helper.dart';

class NovelCard extends StatelessWidget {
  final Novel novel;

  const NovelCard({required this.novel, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NovelDetailScreen(novel: novel),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        height: 240,
        width: 160,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
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
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${Helper.formatNumber(novel.views)} lượt xem',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              novel.title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
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
                const Spacer(),
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
            Text(
              novel.author,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
