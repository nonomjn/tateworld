import 'package:flutter/material.dart';

class NovelDescription extends StatefulWidget {
  final String description;

  const NovelDescription({required this.description, Key? key})
      : super(key: key);

  @override
  _NovelDescriptionState createState() => _NovelDescriptionState();
}

class _NovelDescriptionState extends State<NovelDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mô tả',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Nội dung mô tả căn đều
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.description,
            maxLines: _isExpanded ? null : 4,
            overflow: _isExpanded ? null : TextOverflow.ellipsis,
            textAlign: TextAlign.justify, // Căn đều nội dung
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Nút để mở rộng hoặc thu gọn, căn phải
        Align(
          alignment: Alignment.centerRight, // Căn phải
          child: TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded; // Chuyển đổi trạng thái mở rộng
              });
            },
            child: Row(
              mainAxisSize:
                  MainAxisSize.min, // Chỉ sử dụng kích thước cần thiết
              children: [
                Text(
                  _isExpanded ? 'Thu gọn' : 'Đọc thêm',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 4), // Khoảng cách giữa chữ và icon
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.blue, // Màu icon
                  size: 16, // Kích thước icon
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
