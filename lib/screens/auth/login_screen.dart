import 'package:flutter/material.dart';
import '../../main.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Thêm SafeArea ở đây
        child: Stack(
          children: <Widget>[
            // Ảnh nền cuốn sách từ mạng
            Image.asset(
              'assets/loginbackground.jpg', // URL ảnh nền
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            // Lớp phủ đen để làm dịu ảnh nền
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.5),
            ),
            // Nội dung phần đăng nhập
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Đăng nhập',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Username',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 12.0), // Giảm chiều cao
                            ),
                          ),
                          const SizedBox(height: 16),
                          const TextField(
                            obscureText: true, // Ẩn mật khẩu
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0,
                                  horizontal: 12.0), // Giảm chiều cao
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const MainBottomNavigationBar()),
                              );
                            },
                            child: const Text('Đăng nhập'),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              // Xử lý sự kiện Quên mật khẩu
                            },
                            child: const Text(
                              'Quên mật khẩu?',
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Bạn chưa có tài khoản? "),
                              GestureDetector(
                                onTap: () {
                                  // Điều hướng đến màn hình đăng ký
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterScreen()),
                                  );
                                },
                                child: const Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                    color: Colors.deepPurple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
