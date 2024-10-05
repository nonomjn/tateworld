import 'package:flutter/material.dart';

class LibraryScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const LibraryScreen({
    super.key,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: const Center(child: Text('Library Screen')),
    );
  }
}
