import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../manager/auth_manager.dart';
import '../../manager/user_manager.dart';
import '../../models/user.dart';

class ProfileInfo extends StatefulWidget {
  final User user;
  final int followCount;
  const ProfileInfo({Key? key, required this.user, required this.followCount})
      : super(key: key);

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  bool _isFollowing = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkFollowStatus();
  }

  Future<void> _checkFollowStatus() async {
    final authManager = context.read<AuthManager>();
    // Kiểm tra xem có đang theo dõi người dùng này không
    if (authManager.user?.id != widget.user.id) {
      final isFollowing = await authManager.isFollowing(widget.user.id!);
      setState(() {
        _isFollowing = isFollowing;
      });
    }
  }

  Future<void> _toggleFollowStatus() async {
    final authManager = context.read<AuthManager>();
    setState(() {
      _isLoading = true;
    });
    if (_isFollowing) {
      await authManager.unfollowUser(widget.user);
    } else {
      await authManager.followUser(widget.user);
    }
    setState(() {
      _isFollowing = !_isFollowing;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final authManager = context.watch<AuthManager>();
    final loggedInUser = authManager.user;

    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(
              widget.user.url_avatar ??
                  'https://as-rays.pockethost.io/api/files/_pb_users_auth_/ttsp8nwp1dv3ljk/con_duong_ba_chu_cover_large_aKmK5tfyR1.jpg?token=',
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          widget.user.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.user.username,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),

        // Kiểm tra nếu đây là profile của chính người dùng thì ẩn nút Theo dõi
        if (loggedInUser?.id != widget.user.id)
          ElevatedButton(
            onPressed: _isLoading ? null : _toggleFollowStatus,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white.withOpacity(0.3),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  _isFollowing ? Icons.person_remove : Icons.person_add,
                  color: Colors.white,
                ),
                const SizedBox(width: 8),
                Text(
                  _isFollowing ? 'Bỏ theo dõi' : 'Theo dõi',
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Column(
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
                  widget.followCount.toString(),
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Text(
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
