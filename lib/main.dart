import 'package:flutter/material.dart';

import 'ui/read_novel/read_novel.dart';
import 'ui/profile/profile.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: Colors.deepPurple[200],
          surface: Colors.deepPurple[50],
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
        ),
        textTheme: const TextTheme(
          titleSmall: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 22),
          titleMedium: TextStyle(fontSize: 18),
          bodyLarge: TextStyle(fontSize: 16),
          bodyMedium: TextStyle(fontSize: 14),
          bodySmall: TextStyle(fontSize: 12),
        ),
        useMaterial3: true,
      ),
      home: SafeArea(child: Profile()),
    );
  }
}
