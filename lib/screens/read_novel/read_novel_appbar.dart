
import 'package:flutter/material.dart';

import '../../models/novel.dart';

class AppBarWidget extends StatelessWidget {
  final bool isVisible;
  final VoidCallback toggleVisibility;
  final VoidCallback showChapterListDialog;
  final Novel novel;

  const AppBarWidget({
    super.key,
    required this.isVisible,
    required this.toggleVisibility,
    required this.showChapterListDialog,
    required this.novel,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      top: isVisible ? 0 : -80,
      left: 0,
      right: 0,
      child: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
          onPressed: toggleVisibility,
        ),
        backgroundColor: const Color.fromARGB(255, 39, 33, 33),
        title: Text(novel.novelName, style: const TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 30),
            onPressed: showChapterListDialog,
          ),
        ],
      ),
    );
  }
}
