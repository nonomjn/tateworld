import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const ProfileScreen({
    super.key,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: const Center(child: Text('Profile Screen')),
    );
  }
}
