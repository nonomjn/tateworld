import 'package:flutter/material.dart';
import '../../main.dart';
import '../../screens/login/login.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String _selectedGender = 'Nam'; // Giá trị mặc định là "Nam"
  DateTime _selectedDate = DateTime(2000, 1, 1); // Ngày mặc định

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate, // Hiển thị ngày mặc định
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // Thêm SafeArea ở đây
        child: Stack(
          children: <Widget>[
            // Ảnh nền cuốn sách từ mạng
            Image.asset(
              'assets/loginbackground.jpg', 
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
            // Nội dung phần đăng ký
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
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
                              'Đăng ký',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const TextField(
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Họ và tên',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 12.0), // Giảm chiều cao
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
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email',
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
                            const TextField(
                              obscureText: true, // Ẩn mật khẩu
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Xác nhận mật khẩu',
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 12.0), // Giảm chiều cao
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Ngày sinh với border, căn chỉnh lại kích thước
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ngày sinh:',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 48, // Chiều cao giống với TextField
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        onPressed: () => _selectDate(context),
                                        icon: const Icon(Icons.calendar_today),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Giới tính với border, căn chỉnh lại kích thước
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Giới tính:',
                                  style: TextStyle(fontSize: 16),
                                ),
                                const SizedBox(height: 8),
                                Container(
                                  height: 48, // Chiều cao giống với TextField
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                  ),
                                  child: DropdownButton<String>(
                                    value: _selectedGender,
                                    isExpanded: true,
                                    underline:
                                        const SizedBox(), // Ẩn underline mặc định
                                    items: <String>[
                                      'Nam',
                                      'Nữ',
                                      'Không tiết lộ',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedGender = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            ElevatedButton(
                              onPressed: () {
                                // Điều hướng đến màn hình chính sau khi đăng ký thành công
                                // Navigator.pushReplacement(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) =>
                                //           const BottomNavBarWithStacks()),
                                // );
                              },
                              child: const Text('Đăng ký'),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Bạn đã có tài khoản? "),
                                GestureDetector(
                                  onTap: () {
                                    // Điều hướng đến trang đăng nhập
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Đăng nhập',
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
            ),
          ],
        ),
      ),
    );
  }
}
