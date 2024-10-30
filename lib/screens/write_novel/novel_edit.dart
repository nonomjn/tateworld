import 'dart:io';
import 'package:flutter/material.dart';
import '../../util.dart';
import 'select_genre_dialog.dart';
import 'novelchapter_edit.dart';

class EditNovelScreen extends StatefulWidget {
  const EditNovelScreen({Key? key}) : super(key: key);

  @override
  _EditNovelScreenState createState() => _EditNovelScreenState();
}

class _EditNovelScreenState extends State<EditNovelScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<String> genres = [
    'Hài hước',
    'Kinh dị',
    'Khoa học viễn tưởng',
    'Lãng mạn',
    'Phiêu lưu'
  ];
  List<String> selectedGenres = []; // Lưu danh sách thể loại được chọn

  File? _coverImage;
  final ImagePickerHelper _imagePickerHelper =
      ImagePickerHelper(); // Biến lưu trữ ảnh bìa

  void _selectImage() async {
    File? image = await _imagePickerHelper.pickImage(context);
    if (image != null) {
      setState(() {
        _coverImage = image;
      });
    }
  }

  void _showGenrePicker() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog(
          title: 'Chọn Thể Loại',
          items: genres,
          selectedItems: selectedGenres,
          onConfirm: (selected) {
            setState(() {
              selectedGenres = selected;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Chỉnh Sửa Truyện'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Logic để thêm chương mới
            },
          ),
          PopupMenuButton<String>(
            color: Theme.of(context).colorScheme.surface,
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              if (value == 'Xóa') {
                // Logic để xóa truyện
              } else if (value == 'Xem trước') {
                // Logic để xem trước truyện
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                  onTap: _selectImage, // Hiển thị hộp thoại chọn ảnh
                  child: _coverImage == null
                      ? Container(
                          width: 100,
                          height: 150,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Text(
                              'Sửa Bìa Truyện',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                        )
                      : Image.file(_coverImage!,
                          width: 100, height: 150, fit: BoxFit.cover)),
            ),
            const SizedBox(height: 20),
            buildTextField('Tiêu Đề Truyện', _titleController,
                hintText: 'Nhập tiêu đề truyện ở đây'),
            const SizedBox(height: 20),
            const Divider(), // Đường gạch ngang giữa các trường
            buildTextField(
              'Mô Tả Truyện',
              _descriptionController,
              hintText:
                  'Tuyện nói về một người lạc vào từng thế giới khác nhau để làm các nhiệm vụ khác nhau và giải cứu thế giới.',
              maxLines: null, // Cho phép nhập không giới hạn số dòng
            ),
            const SizedBox(height: 20),
            const Divider(), // Đường gạch ngang giữa các trường
            const Text(
              'Thể Loại Truyện',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _showGenrePicker, // Hiển thị hộp thoại chọn thể loại
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  selectedGenres.isNotEmpty
                      ? selectedGenres.join(', ')
                      : 'Chọn Thể Loại',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Bảng Mục Lục',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    // Logic mở thiết lập
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            buildChapterItem('Chương 1', 'Draft - updated 25 tháng 9, 2024'),
            const Divider(),
            buildChapterItem('Chương 2', 'Draft - updated 25 tháng 9, 2024'),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: GestureDetector(
                onTap: () {
                  // Logic thêm chương mới
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WriteChapterScreen()),
                      );
                    },
                    child: Text(
                      '+ Thêm Chương Mới',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {String? hintText, int? maxLines}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText ?? '',
            hintStyle: const TextStyle(color: Colors.grey), // Màu văn bản gợi ý
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none, // Loại bỏ đường viền
          ),
          style:
              const TextStyle(color: Colors.black), // Hiển thị văn bản nhập vào
          maxLines: maxLines, // Cho phép nhập nhiều dòng văn bản
        ),
      ],
    );
  }

  Widget buildChapterItem(String chapterTitle, String lastUpdated) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          chapterTitle,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5),
        Text(
          lastUpdated,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
      ],
    );
  }
}

  // MultiSelectDialog Widget
