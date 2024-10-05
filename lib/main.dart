import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/library_screen.dart';
import 'screens/profile_screen.dart';
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
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
                backgroundColor: Colors.black,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.library_books),
                label: 'Library',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
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
                  return ProfileScreen(navigatorKey: _navigatorKeys[index]);
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
