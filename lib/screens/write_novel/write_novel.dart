import 'package:flutter/material.dart';

class WriteNovelScreen extends StatelessWidget{
  const WriteNovelScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write Novel'),
      ),
      body: const Center(
        child: Text('Write Novel Screen'),
      ),
    );
  }
}