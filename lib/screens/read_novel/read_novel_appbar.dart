import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  final bool isVisible;
  final VoidCallback toggleVisibility;
  final VoidCallback showChapterListDialog;

  const AppBarWidget({
    Key? key,
    required this.isVisible,
    required this.toggleVisibility,
    required this.showChapterListDialog,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 500),
      top: isVisible ? 0 : -80,
      left: 0,
      right: 0,
      child: AppBar(
        backgroundColor: const Color.fromARGB(255, 39, 33, 33),
        title: const Text('ReadNovel', style: TextStyle(color: Colors.white)),
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
