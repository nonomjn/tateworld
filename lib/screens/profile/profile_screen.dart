import 'dart:ui';
import 'package:provider/provider.dart';
import '/screens/profile/edit_profile.dart';
import 'package:flutter/material.dart';

import '../../manager/user_manager.dart';
import '/manager/auth_manager.dart';
import 'profile_header.dart';
import 'profile_info.dart';
import 'profile_introduction.dart';
import 'profile_followers.dart';
import '../auth/login_screen.dart';
import '../../models/user.dart';

class ProfileScreen extends StatefulWidget {
  final String? userId; // Sử dụng String? để `userId` có thể là null
  const ProfileScreen({super.key, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  bool _isSettingsOpen = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late String userId;
  late bool isCurrentUser;
  late User user;

  @override
  void initState() {
    super.initState();

    final currentUser = context.read<AuthManager>().user;
    userId = widget.userId ?? currentUser?.id ?? '';
    isCurrentUser = (widget.userId == null || widget.userId == currentUser?.id);

    if (isCurrentUser) {
      // Nếu là người dùng hiện tại, lấy thông tin từ AuthManager
      user = currentUser!;
    } else {
      // Nếu không phải người dùng hiện tại, lấy thông tin từ UserManager dựa trên userId
      final userManager = context.read<UserManager>();
      user = userManager.getUserById(userId);
    }

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(_controller);
  }

  void _toggleSettings() {
    setState(() {
      _isSettingsOpen = !_isSettingsOpen;
      if (_isSettingsOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true, // Để AppBar nằm trên ảnh nền
        appBar: AppBar(
          backgroundColor: Colors.transparent, // AppBar trong suốt
          elevation: 0, // Không có bóng
          actions: isCurrentUser &&
                  !_isSettingsOpen // Chỉ hiển thị nếu là người dùng hiện tại và hộp thoại setting chưa mở
              ? [
                  IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onPressed: _toggleSettings,
                  ),
                ]
              : null, // Ẩn nút Settings nếu không phải là người dùng hiện tại
        ),
        body: Stack(
          children: [
            ProfileHeader(), // Gọi widget Header với userId
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  ProfileInfo(user: user),
                  ProfileIntroduction(user: user),
                  ProfileFollowers(user: user),
                
                ],
              ),
            ),
            if (_isSettingsOpen) // Hiển thị hộp thoại cài đặt khi mở
              GestureDetector(
                onTap: _toggleSettings,
                child: Container(
                  color: Colors.black.withOpacity(0.5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: SlideTransition(
                      position: _offsetAnimation,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 2 / 3,
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              color: Colors.grey[200],
                              height: 60,
                              child: const Center(
                                child: Text(
                                  'Cài đặt',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            ListTile(
                              leading: const Icon(Icons.person),
                              title: const Text('Đổi thông tin cá nhân'),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const EditProfileScreen(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.lock),
                              title: const Text('Đổi mật khẩu'),
                              onTap: _toggleSettings,
                            ),
                            ListTile(
                              leading: const Icon(Icons.logout),
                              title: const Text('Đăng xuất'),
                              onTap: () {
                                context.read<AuthManager>().logout();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.notifications),
                              title: const Text('Thông báo'),
                              onTap: _toggleSettings,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
