import 'package:flutter/material.dart';
import '../../models/novel_manager.dart'; 

class ChapterList extends StatelessWidget {
  final ChapterModel chapterModel; 

  
  const ChapterList({
    Key? key,
    required this.chapterModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = chapterModel; 

    return Align(
      alignment: Alignment.centerRight, 
      child: SafeArea(
        child: Material(
          color: Colors.white, 
          elevation: 16,
          child: Container(
            width: MediaQuery.of(context).size.width *
                0.68,
            height: MediaQuery.of(context)
                .size
                .height,
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hiển thị ảnh truyện và tên truyện
                Row(
                  children: [
                    Image.network(
                      model.novelImageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Tên truyện: ${model.novelTitle}',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Danh sách chương:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // Hiển thị danh sách chương bằng ListView
                Expanded(
                  child: ListView.builder(
                    itemCount: model.chapters.length,
                    itemBuilder: (BuildContext context, int index) {
                      // Nếu chương hiện tại, đổi màu nền và màu chữ
                      bool isCurrentChapter = index == model.currentChapter;

                      return Container(
                        color: isCurrentChapter
                            ? Colors
                                .orange[100]
                            : Colors.transparent, 
                        child: ListTile(
                          leading: Icon(Icons.book, color: Colors.orange),
                          title: Text(
                            model.chapters[index],
                            style: TextStyle(
                              color: isCurrentChapter
                                  ? Colors
                                      .orange 
                                  : Colors.black,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(
                                context); 
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
