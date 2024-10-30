import 'package:flutter/material.dart';

class SearchNovelScreen extends StatelessWidget {
  const SearchNovelScreen({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tìm kiếm'),
        ),
        body: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm truyện hoặc tác giả...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            const TabBar(
              tabs: [
                Tab(text: 'Truyện'),
                Tab(text: 'Tác giả'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  NovelListView(),
                  AuthorListView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NovelListView extends StatelessWidget {
  final List<Map<String, String>> novels = [
    {
      'title': 'Bắt Ta Làm Cung Nữ? Ta Liền Cho Bạo Quân Quỳ',
      'chapter': 'Chương 314',
      'views': '2.54M',
      'tags': 'Cổ Trang, Ngôn Tình, Hệ Thống, Tình Yêu, Hài Hước',
      'author': 'Bánh Bèo Hội Quán',
      'imageUrl':
          'https://i.pinimg.com/originals/dc/de/2b/dcde2beb30864f06843c42699a250675.jpg',
    },
    {
      'title': 'Đừng Ngây Thơ Nữa, Hãy Phục Tùng',
      'chapter': 'Chương 151',
      'views': '1.19M',
      'tags': 'Hài Hước, Ngọt Sủng, Ngôn Tình, Showbiz, Tình Yêu',
      'author': 'Sip Tea Team',
      'imageUrl':
          'https://i.pinimg.com/originals/ea/6f/d3/ea6fd3a4b6037bd21347ef17323e0cdc.jpg',
    },
    {
      'title': 'Võ Luyện Đỉnh Phong',
      'chapter': 'Chương 3760',
      'views': '864K',
      'tags': 'Huyền Huyễn, Hậu Cung',
      'author': 'Thánh Leech',
      'imageUrl':
          'https://i.pinimg.com/originals/63/0b/f0/630bf06f2dec3396f86bd2638977cbfe.jpg',
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Enlarge Cover Image
                Image.network(
                  novel['imageUrl']!,
                  width: 110,
                  height: 180,
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
                        novel['chapter']!,
                        style: const TextStyle(
                            fontSize: 12), // Reduce chapter font size
                      ),
                      Text(
                        'Views: ${novel['views']}',
                        style: const TextStyle(
                            fontSize: 12), // Reduce views font size
                      ),
                      const SizedBox(height: 2),
                      // Tags displayed as chips (3 per row)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Wrap(
                            spacing: 4.0, // Reduced spacing to fit 3 per row
                            runSpacing: 2.0,
                            alignment: WrapAlignment.start,
                            children:
                                novel['tags']!.split(', ').take(6).map((tag) {
                              return Chip(
                                label: Text(tag,
                                    style: const TextStyle(
                                        fontSize: 10)), // Smaller chip font
                                backgroundColor: Colors.grey[200],
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                padding: const EdgeInsets.all(4),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Author: ${novel['author']}',
                        style: const TextStyle(
                            fontSize: 12), // Reduce author font size
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AuthorListView extends StatelessWidget {
  final List<Map<String, dynamic>> authors = [
    {
      'name': 'Quẫn Quệ Comic',
      'stories': '347 truyện',
      'followers': '8.02K theo dõi',
      'avatarUrl': 'https://randomuser.me/api/portraits/men/32.jpg',
    },
    {
      'name': 'Miêu Dạ Tử',
      'stories': '82 truyện',
      'followers': '426 theo dõi',
      'avatarUrl': 'https://randomuser.me/api/portraits/men/22.jpg',
    },
    {
      'name': 'Tester',
      'stories': '2 truyện',
      'followers': '31 theo dõi',
      'avatarUrl': 'https://randomuser.me/api/portraits/men/12.jpg',
    },
    {
      'name': 'FM COMIC',
      'stories': '13 truyện',
      'followers': '999 theo dõi',
      'avatarUrl': 'https://randomuser.me/api/portraits/men/2.jpg',
    },
    // Add more authors as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: authors.length,
      itemBuilder: (context, index) {
        final author = authors[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Author Avatar
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(author['avatarUrl']!),
                ),
                const SizedBox(width: 20),
                // Author Info (name, stories, followers)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        author['name']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 3),
                      Text(
                        author['stories']!,
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        author['followers']!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
