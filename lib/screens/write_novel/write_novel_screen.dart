import 'package:flutter/material.dart';
import 'novel_edit.dart';

class WriteNovelScreen extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const WriteNovelScreen({
    super.key,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write Novel'),
      ),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditNovelScreen()));
          },
          child: Text('Write Novel Screen'),
        ),
      ),
    );
  }
}
