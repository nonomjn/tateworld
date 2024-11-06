import 'package:flutter/material.dart';
import 'package:tateworld/manager/auth_manager.dart';
import 'edit_profile.dart';
import 'package:provider/provider.dart';
import '../auth/login_screen.dart';

class SettingsDrawer extends StatelessWidget {
  final VoidCallback onClose;

  const SettingsDrawer({Key? key, required this.onClose}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  builder: (context) => EditProfileScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Đổi mật khẩu'),
            onTap: onClose,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Đăng xuất'),
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
              context.read<AuthManager>().logout();
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Thông báo'),
            onTap: onClose,
          ),
        ],
      ),
    );
  }
}
