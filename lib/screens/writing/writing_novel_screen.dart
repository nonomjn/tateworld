import 'package:flutter/material.dart';

class WritingNovelScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const WritingNovelScreen({super.key, required this.navigatorKey});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Viết truyện'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                // TODO: Navigate to CreateNovelScreen
              },
            ),
          ],
        ),
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Đã đăng tải'),
                Tab(text: 'Bản thảo'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  NovePostedListView(),
                  NovelDraftListView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NovelDraftListView extends StatelessWidget {
  final List<Map<String, String>> novels = [
    {
      'title': 'Bắt Ta Làm Cung Nữ? Ta Liền Cho Bạo Quân Quỳ',
      'chapter': '314',
      'draft': '4',
      'imageUrl':
          'https://i.pinimg.com/originals/dc/de/2b/dcde2beb30864f06843c42699a250675.jpg',
    },
    {
      'title': 'Bắt Ta Làm Cung Nữ? Ta Liền Cho Bạo Quân Quỳ',
      'chapter': '314',
      'draft': '5',
      'imageUrl':
          'https://i.pinimg.com/originals/dc/de/2b/dcde2beb30864f06843c42699a250675.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: novels.length,
      itemBuilder: (context, index) {
        final novel = novels[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Enlarge Cover Image
              Image.network(
                novel['imageUrl']!,
                width: 80,
                height: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 20),
              // Novel Info (title, chapter, views, tags, author)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      novel['title']!,
                      style: const TextStyle(
                        fontSize: 14, // Smaller font size for title
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Số chương đã đăng: ${novel['chapter']!}',
                      style: const TextStyle(
                          fontSize: 12), // Reduce chapter font size
                    ),
                    Text(
                      '${novel['draft']} bản thảo',
                      style: const TextStyle(
                          fontSize: 12), // Reduce views font size
                    ),
                  ],
                ),
              ),

              PopupMenuButton(
                icon: const Icon(Icons.more_vert_sharp),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      child: Text('Xem trước'),
                    ),
                    const PopupMenuItem(
                      child: Text('Xóa'),
                    ),
                  ];
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class NovePostedListView extends StatelessWidget {
  final List<Map<String, String>> novels = [
    {
      'title': 'Bắt Ta Làm Cung Nữ? Ta Liền Cho Bạo Quân Quỳ',
      'chapter': '314',
      'views': '2.54M',
      'comments': '1.3K',
      'draft': '3',
      'imageUrl':
          'https://i.pinimg.com/originals/dc/de/2b/dcde2beb30864f06843c42699a250675.jpg',
    },
    {
      'title': 'Bắt Ta Làm Cung Nữ? Ta Liền Cho Bạo Quân Quỳ',
      'chapter': '314',
      'views': '2.54M',
      'comments': '1.2K',
      'draft': '4',
      'imageUrl':
          'https://i.pinimg.com/originals/dc/de/2b/dcde2beb30864f06843c42699a250675.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: novels.length,
      itemBuilder: (context, index) {
        final novel = novels[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Enlarge Cover Image
              Image.network(
                novel['imageUrl']!,
                width: 80,
                height: 120,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 20),
              // Novel Info (title, chapter, views, tags, author)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      novel['title']!,
                      style: const TextStyle(
                        fontSize: 14, // Smaller font size for title
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Số chương đã đăng: ${novel['chapter']!}',
                      style: const TextStyle(
                          fontSize: 12), // Reduce chapter font size
                    ),
                    Text(
                      '${novel['draft']} bản thảo',
                      style: const TextStyle(
                          fontSize: 12), // Reduce views font size
                    ),
                    const SizedBox(height: 2),
                    // Tags displayed as chips (3 per row)
                    Text(
                      'Lượt xem: ${novel['views']}',
                      style: const TextStyle(
                          fontSize: 12), // Reduce author font size
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Bình luận: ${novel['comments']}',
                      style: const TextStyle(
                          fontSize: 12), // Reduce author font size
                    ),
                  ],
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert_sharp),
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem(
                      child: Text('Chia sẻ'),
                    ),
                    const PopupMenuItem(
                      child: Text('Xem trước'),
                    ),
                    const PopupMenuItem(
                      child: Text('Dừng đăng tải'),
                    ),
                    const PopupMenuItem(
                      child: Text('Xóa'),
                    ),
                  ];
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
