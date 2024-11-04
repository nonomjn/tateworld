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
  final String? userId;
  const ProfileScreen({super.key, this.userId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  bool _isSettingsOpen = false;
  bool isLoading = true;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late String userId;
  late bool isCurrentUser;
  User? user;
  List<User> followers = [];

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

    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    final currentUser = context.read<AuthManager>().user;
    final userManager = context.read<UserManager>();

    userId = widget.userId ?? currentUser?.id ?? '';
    isCurrentUser = (widget.userId == null || widget.userId == currentUser?.id);

    if (isCurrentUser) {
      user = currentUser;
    } else {
      user = await userManager.addUser(userId);
    }

    if (user != null) {
      await userManager.fetchFollowers(user!);
      followers = userManager.getFollowersForUser(user!.id!);
    }

    setState(() {
      isLoading = false;
    });
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
    if (isLoading || user == null || followers.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: isCurrentUser && !_isSettingsOpen
              ? [
                  IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onPressed: _toggleSettings,
                  ),
                ]
              : null,
        ),
        body: Stack(
          children: [
            ProfileHeader(),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  ProfileInfo(user: user!, followCount: followers.length),
                  ProfileIntroduction(user: user!),
                  ProfileFollowers(user: user!, followers: followers),
                ],
              ),
            ),
            if (_isSettingsOpen)
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
