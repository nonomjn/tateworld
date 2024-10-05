import 'package:flutter/material.dart';

class Themes {
  // Màu nền vàng nhạt, chữ đen
  static final ThemeData lightYellowTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFFFF8E1),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
    ),
  );

  // Nền trắng, chữ đen
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
    ),
  );

  // Nền đen, chữ trắng
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
    ),
  );
}
