import 'package:flutter/material.dart';

class ProfileFollowers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Danh sách người theo dõi', // Tiêu đề lớn cho phần này
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Sửa chỗ này
                      SizedBox(
                        height: 100, // Chiều cao cố định cho danh sách ngang
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 10, // Giả sử có 10 người theo dõi
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage: NetworkImage(
                                      'https://randomuser.me/api/portraits/men/$index.jpg', // Avatar người theo dõi
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text('User $index'),
                                ],
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
