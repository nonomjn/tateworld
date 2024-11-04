import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../manager/user_manager.dart';

class ProfileIntroduction extends StatelessWidget {
  final User user;
  const ProfileIntroduction({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 8),
          Text(
            user.introduce?.isNotEmpty == true
                ? user.introduce!
                : 'Chưa có giới thiệu',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 20),
          const Text(
            'Truyện đã đăng',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          // Danh sách truyện
          Container(
            padding: const EdgeInsets.all(10),
            height: MediaQuery.of(context).size.height * 0.18,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5, // Giả sử có 5 truyện
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey[200],
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 2 / 3,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: AspectRatio(
                            aspectRatio: 3 / 5,
                            child: Container(
                              decoration: BoxDecoration(
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
                                const SizedBox(height: 4),
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
                                const SizedBox(height: 4),
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
