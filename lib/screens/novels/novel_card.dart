import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/novel.dart';
import '../../manager/chapter_manager.dart';
import 'novel_detail_screen.dart';
import '../util/helper.dart';

class NovelCard extends StatefulWidget {
  final Novel novel;

  const NovelCard({required this.novel, super.key});

  @override
  State<NovelCard> createState() => _NovelCardState();
}

class _NovelCardState extends State<NovelCard> {
  late Future<void> _fetchChapters;

  @override
  void initState() {
    super.initState();
    _fetchChapters =
        context.read<ChapterManager>().fetchChapters(widget.novel.id!);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.novel.id);
    return FutureBuilder<void>(
      future: _fetchChapters,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Có lỗi xảy ra: ${snapshot.error}'));
        } else {
          final totalViews = context.watch<ChapterManager>().totalViews;
          final totalChapters = context.watch<ChapterManager>().totalChapters;
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NovelDetailScreen(novel: widget.novel),
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
                          widget.novel.urlImageCover,
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
                                '${Helper.formatNumber(totalViews)} lượt xem',
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
                    widget.novel.novelName,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
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
                      // Có thể thêm thông tin đánh giá ở đây
                      const Spacer(),
                      const Icon(
                        Icons.menu_book,
                        color: Colors.grey,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '$totalChapters',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
