import 'package:flutter/material.dart';

import '../../manager/novels_manager.dart';
import '../novels/novel_detail_screen.dart';
import '../../models/novel.dart';
import '../../manager/storage_manager.dart';

class StoreTab extends StatefulWidget {
  const StoreTab({super.key});

  @override
  State<StoreTab> createState() => _StoreTabState();
}

class _StoreTabState extends State<StoreTab> {
  late Future<void> _fetchStorage;

  @override
  void initState() {
    super.initState();
    _fetchStorage = StorageManager().fetchStorage();
  }

  @override
  Widget build(BuildContext context) {
    final novels = NovelsManager().getNovels();
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.4,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 10,
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
                novel.urlImageCover,
                fit: BoxFit.cover,
                height: 200,
                width: 140,
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    novel.novelName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
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
                          // Text(
                          //   '${novel.rating}',
                          //   style: const TextStyle(fontSize: 12),
                          // ),
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
                          // Text(
                          //   '${novel.chapters}',
                          //   style: const TextStyle(fontSize: 12),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
