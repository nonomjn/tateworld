import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/men/32.jpg', // Avatar
            ),
          ),
        ),
        SizedBox(height: 16),
        const Text(
          'Tên người dùng',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        const Text(
          'username',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            // Hành động khi nhấn nút theo dõi
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_add, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Theo dõi',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white.withOpacity(0.3),
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          ),
        ),
        const SizedBox(height: 16),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  '12',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Tác phẩm',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(width: 50),
            Column(
              children: [
                Text(
                  '1200',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Người theo dõi',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
