import 'package:flutter/material.dart';

class SearchNovelScreen extends StatelessWidget {
  const SearchNovelScreen({
    super.key
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
