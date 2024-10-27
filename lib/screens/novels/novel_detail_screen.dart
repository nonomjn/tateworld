import 'package:flutter/material.dart';
import '../../models/novel.dart';
import 'novel_description.dart';
import '../read_novel/read_novel.dart';

class NovelDetailScreen extends StatelessWidget {
  final Novel novel;

  const NovelDetailScreen({required this.novel, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Cho phép nội dung body đi phía sau AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Đặt AppBar trong suốt
        elevation: 0, // Loại bỏ bóng của AppBar
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // Nội dung chính
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        novel.imageUrl,
                        width: 200,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      novel.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      novel.author,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Column(
                        children: [
                          Icon(Icons.remove_red_eye),
                          SizedBox(height: 4),
                          // Text(novel.views.toString()),
                          Text('1000'),
                        ],
                      ),
                      const Column(
                        children: [
                          Icon(Icons.star),
                          SizedBox(height: 4),
                          // Text(novel.rating.toString()),
                          Text('4.5'),
                        ],
                      ),
                      Column(
                        children: [
                          const Icon(Icons.menu_book),
                          const SizedBox(height: 4),
                          Text(novel.chapters.toString()),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  NovelDescription(description: novel.description),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Nút Đọc mới nhất
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12), // Điều chỉnh padding
                          backgroundColor: Colors.blueAccent, // Màu nền
                          foregroundColor: Colors.white, // Màu chữ
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Bo tròn viền
                          ),
                          elevation: 5, // Tạo độ nổi (shadow)
                        ),
                        child: const Text(
                          'Đọc mới nhất',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Nút Đọc từ đầu
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ReadNovel(id:"d"),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12), // Điều chỉnh padding
                          backgroundColor: Colors.green, // Màu nền khác
                          foregroundColor: Colors.white, // Màu chữ
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(20), // Bo tròn viền
                          ),
                          elevation: 5, // Tạo độ nổi (shadow)
                        ),
                        child: const Text(
                          'Đọc từ đầu',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Danh sách chương',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Sử dụng ListView.builder với shrinkWrap và NeverScrollableScrollPhysics
                        ListView.builder(
                          shrinkWrap:
                              true, // Đảm bảo chỉ chiếm đúng kích thước cần thiết
                          physics:
                              const NeverScrollableScrollPhysics(), // Tắt cuộn, vì không cần trong trường hợp này
                          itemCount:
                              novel.chapters, // Đếm số chương trong novel
                          itemBuilder: (context, index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text('Chapter ${index + 1}'),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            );
                          },
                        ),
                      ],
                    ),
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
