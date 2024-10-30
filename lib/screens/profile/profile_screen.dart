import 'dart:ui'; // Để sử dụng hiệu ứng làm mờ
import 'package:flutter/material.dart';
import 'profile_header.dart';
import 'profile_info.dart';
import 'profile_introduction.dart';
import 'profile_followers.dart';

class ProfileSrceen extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const ProfileSrceen({
    super.key,
    required this.navigatorKey,
  });

  @override
  State<ProfileSrceen> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileSrceen> with TickerProviderStateMixin {
  bool _isSettingsOpen = false;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      extendBodyBehindAppBar: true, // Để AppBar nằm trên ảnh nền
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar trong suốt
        elevation: 0, // Không có bóng
        actions: _isSettingsOpen
            ? null // Ẩn nút Settings khi hộp thoại cài đặt mở
            : [
                IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    _toggleSettings();
                  },
                ),
              ],
      ),
      body: Stack(
        children: [
          ProfileHeader(), // Gọi widget Header
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 50),
                ProfileInfo(), //
                ProfileIntroduction(),
                ProfileFollowers(),
              ],
            ),
          ),
          // Hộp thoại cài đặt trượt từ bên phải chiếm 2/3 màn hình
          _isSettingsOpen
              ? GestureDetector(
                  onTap: () {
                    _toggleSettings();
                  },
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
                              // Danh sách các mục trong phần cài đặt
                              ListTile(
                                leading: const Icon(Icons.person),
                                title: const Text('Đổi thông tin cá nhân'),
                                onTap: () {
                                  _toggleSettings();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.lock),
                                title: const Text('Đổi mật khẩu'),
                                onTap: () {
                                  _toggleSettings();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.logout),
                                title: const Text('Đăng xuất'),
                                onTap: () {
                                  _toggleSettings();
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.notifications),
                                title: const Text('Thông báo'),
                                onTap: () {
                                  _toggleSettings();
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
