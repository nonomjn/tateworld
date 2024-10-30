import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/library_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'screens/search_novel_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Novel Reader',
      debugShowCheckedModeBanner: false,
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
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const BottomNavBarWithStacks(),
    );
  }
}

class BottomNavBarWithStacks extends StatefulWidget {
  const BottomNavBarWithStacks({super.key});

  @override
  _BottomNavBarWithStacksState createState() => _BottomNavBarWithStacksState();
}

class _BottomNavBarWithStacksState extends State<BottomNavBarWithStacks> {
  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Kiểm tra xem navigator hiện tại có thể quay lại không
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentIndex].currentState!.maybePop();

        // Nếu ở route đầu tiên của tab hiện tại, thoát ứng dụng
        if (isFirstRouteInCurrentTab) {
          return true;
        }

        // Nếu không, chỉ quay lại stack trước trong navigator của tab hiện tại
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              _buildOffstageScreen(0),
              _buildOffstageScreen(1),
              _buildOffstageScreen(2),
              _buildOffstageScreen(3),
              _buildOffstageScreen(4),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Trang chủ',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Thư viện',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Tìm kiếm',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.create),
                label: 'Viết truyện',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Trang cá nhân',
                backgroundColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageScreen(int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: Navigator(
        key: _navigatorKeys[index],
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
            builder: (context) {
              switch (index) {
                case 0:
                  return HomeScreen(navigatorKey: _navigatorKeys[index]);
                case 1:
                  return LibraryScreen(navigatorKey: _navigatorKeys[index]);
                case 2:
                  return SearchNovelScreen(navigatorKey: _navigatorKeys[index]);
                case 3:
                  return ProfileSrceen(navigatorKey: _navigatorKeys[index]);
                case 4:
                  return ProfileSrceen(navigatorKey: _navigatorKeys[index]);
                default:
                  return HomeScreen(navigatorKey: _navigatorKeys[index]);
              }
            },
          );
        },
      ),
    );
  }
}
