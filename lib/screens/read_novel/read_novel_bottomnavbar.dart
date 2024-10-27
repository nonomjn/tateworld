import 'dart:ffi';

import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final bool isVisible;
  final VoidCallback showFontSettings;
  final VoidCallback showComment;

  const BottomNavBar({
    super.key,
    required this.isVisible,
    required this.showFontSettings,
    required this.showComment,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      bottom: isVisible ? 0 : -80,
      left: 0,
      right: 0,
      child: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 83, 69, 69),
        selectedItemColor: const Color.fromARGB(255, 194, 139, 88),
        unselectedItemColor: const Color.fromARGB(255, 194, 139, 88),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index == 3) {
            showFontSettings();
          }
          if(index == 1){
            showComment();
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.thumb_up), label: 'Vote'),
          BottomNavigationBarItem(icon: Icon(Icons.comment), label: 'Comment'),
          BottomNavigationBarItem(
              icon: Icon(Icons.share, size: 25), label: 'Share'),
          BottomNavigationBarItem(
              icon: Icon(Icons.text_format, size: 30), label: 'Aa'),
        ],
      ),
    );
  }
}
