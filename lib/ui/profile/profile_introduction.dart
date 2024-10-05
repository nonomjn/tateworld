import 'package:flutter/material.dart';

class ProfileIntroduction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Giới thiệu',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          const Text(
            'Đây là thông tin giới thiệu cá nhân của người dùng...',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 20),
          const Text(
            'Truyện đã đăng',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Danh sách truyện
          Container(
            padding: EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Giả sử có 5 truyện
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[200],
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: AspectRatio(
                            aspectRatio: 3 / 5,
                            child: Container(
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://images.pexels.com/photos/1731619/pexels-photo-1731619.jpeg'), // Ảnh bìa
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Tên truyện $index',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 4),
                                const Row(
                                  children: [
                                    Icon(Icons.remove_red_eye, size: 12),
                                    SizedBox(width: 4),
                                    Text('1.2K',
                                        style: TextStyle(fontSize: 12)),
                                    SizedBox(width: 10),
                                    Icon(Icons.thumb_up, size: 12),
                                    SizedBox(width: 4),
                                    Text('500', style: TextStyle(fontSize: 12)),
                                    SizedBox(width: 10),
                                    Icon(Icons.list, size: 12),
                                    SizedBox(width: 4),
                                    Text('12', style: TextStyle(fontSize: 12)),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Mô tả truyện rất dài và có thể chứa nhiều thông tin... $index',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
