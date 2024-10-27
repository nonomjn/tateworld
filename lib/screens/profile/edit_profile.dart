import 'dart:io';
import 'package:flutter/material.dart';
import '../../util.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  File? _avatarImage;
  File? _coverImage;
  final ImagePickerHelper _imagePickerHelper = ImagePickerHelper();

  DateTime? _selectedDateOfBirth;
  String _selectedGender = 'Nam'; // Mặc định là Nam
  List<String> _genders = ['Nam', 'Nữ', 'Khác'];

  void _selectAvatarImage() async {
    File? image = await _imagePickerHelper.pickImage(context);
    if (image != null) {
      setState(() {
        _avatarImage = image;
      });
    }
  }

  void _selectCoverImage() async {
    File? image = await _imagePickerHelper.pickImage(context);
    if (image != null) {
      setState(() {
        _coverImage = image;
      });
    }
  }

  void _selectDateOfBirth() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDateOfBirth = picked;
      });
    }
  }

  void _selectGender(String? value) {
    setState(() {
      _selectedGender = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chỉnh Thông Tin Cá Nhân',
          style: Theme.of(context).textTheme.titleSmall,),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Lưu thông tin người dùng
            },
            child: const Text(
              'Lưu',
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar và ảnh bìa
            Center(
              child: GestureDetector(
                onTap: _selectAvatarImage,
                child: _avatarImage == null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person,
                            size: 50, color: Colors.black54),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: FileImage(_avatarImage!),
                      ),
              ),
            ),
            const SizedBox(height: 5),
            const Divider(),
            Center(
              child: GestureDetector(
                onTap: _selectCoverImage,
                child: _coverImage == null
                    ? Container(
                        width: double.infinity,
                        height: 150,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Text(
                            'Sửa Ảnh Bìa',
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      )
                    : Image.file(
                        _coverImage!,
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            const SizedBox(height: 5),
            const Divider(),
            buildTextField(
              'Tên',
              _displayNameController,
              hintText: 'Trieu Vi',
            ),
            const SizedBox(height: 5),
            const Divider(),
            buildTextField(
              'Tên Đăng Nhập',
              _usernameController,
              hintText: 'trieuvi123',
            ),
            const SizedBox(height: 5),
            const Divider(),
            buildTextField(
              'Giới Thiệu Bản Thân',
              _bioController,
              hintText: 'Đây là giới thiệu bản thân',
              maxLines: null,
            ),
            const SizedBox(height: 5),
            const Divider(),
            const Text(
              'Ngày Sinh',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            GestureDetector(
              onTap: _selectDateOfBirth,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  _selectedDateOfBirth != null
                      ? '${_selectedDateOfBirth!.day}/${_selectedDateOfBirth!.month}/${_selectedDateOfBirth!.year}'
                      : '1/1/2000',
                  style: const TextStyle(color: Colors.black),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Divider(),
            const Text(
              'Giới Tính',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            DropdownButton<String>(
              value: _selectedGender,
              onChanged: _selectGender,
              items: _genders
                  .map<DropdownMenuItem<String>>(
                    (String value) => DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 5),
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
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText ?? '',
            hintStyle: const TextStyle(color: Colors.grey),
            filled: true,
            fillColor: Colors.white,
            border: InputBorder.none,
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
