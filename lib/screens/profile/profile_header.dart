import 'dart:ui'; // Để sử dụng hiệu ứng làm mờ
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            'https://images.unsplash.com/photo-1506748686214-e9df14d4d9d0', // Ảnh nền
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Container(
          color: Colors.black.withOpacity(0.7), // Lớp phủ màu đen
        ),
      ),
    );
  }
}
