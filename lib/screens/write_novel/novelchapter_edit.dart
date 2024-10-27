import 'package:flutter/material.dart';

class WriteChapterScreen extends StatefulWidget {
  const WriteChapterScreen({Key? key}) : super(key: key);

  @override
  _WriteChapterScreenState createState() => _WriteChapterScreenState();
}

class _WriteChapterScreenState extends State<WriteChapterScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Viết Truyện'),
        actions: [
          // Nút đăng (chữ "Đăng" thay vì icon)
          TextButton(
            onPressed: () {
              saveContent(); // Gọi hàm lưu khi nhấn "Đăng"
            },
            child: const Text(
              'Đăng',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
          // Nút ba chấm dọc mở PopupMenuButton
          PopupMenuButton<String>(
            color: Theme.of(context).colorScheme.surface,
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'Xóa') {
                clearContent(); // Gọi hàm xóa nội dung khi nhấn "Xóa"
              } else if (value == 'Xem trước') {
                previewContent(); // Gọi hàm xem trước nội dung khi nhấn "Xem trước"
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Xóa',
                child: Text('Xóa'),
              ),
              const PopupMenuItem<String>(
                value: 'Xem trước',
                child: Text('Xem trước'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // TextField để nhập tiêu đề chương
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Đặt Tiêu đề cho Chương Truyện của bạn',
                border: InputBorder.none,
              ),
              style: TextStyle(fontSize: Theme.of(context).textTheme.titleMedium?.fontSize, fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          // TextField để nhập nội dung truyện
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _contentController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: 'Nhập nội dung truyện của bạn...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm lưu nội dung vào cơ sở dữ liệu hoặc biến
  void saveContent() {
    String title = _titleController.text; // Lấy nội dung tiêu đề
    String content = _contentController.text; // Lấy nội dung truyện

    // Hiển thị tiêu đề và nội dung đã nhập trên console (hoặc có thể lưu vào cơ sở dữ liệu ở đây)
    print('Tiêu đề: $title');
    print('Nội dung: $content');
  }

  // Hàm xóa nội dung
  void clearContent() {
    setState(() {
      _titleController.clear(); // Xóa tiêu đề
      _contentController.clear(); // Xóa nội dung truyện
    });
  }

  // Hàm xem trước nội dung
  void previewContent() {
    String previewTitle = _titleController.text;
    String previewContent = _contentController.text;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(previewTitle.isEmpty ? 'Chưa có tiêu đề' : previewTitle),
          content: SingleChildScrollView(
            child: Text(
                previewContent.isEmpty ? 'Chưa có nội dung' : previewContent),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }
}
