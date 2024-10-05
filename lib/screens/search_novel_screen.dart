import 'package:flutter/material.dart';

class SearchNovelScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const SearchNovelScreen({
    super.key,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Novel'),
      ),
      body: const Center(child: Text('Search Novel Screen')),
    );
  }
}
