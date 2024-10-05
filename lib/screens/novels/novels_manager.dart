import '../../models/novel.dart';

class NovelsManager {
  final List<Novel> novels = [
    Novel(
      title: 'Novel 1',
      author: 'Author 1',
      chapters: 10,
      description:
          'Description of Novel 1 lorem ipsum dolor sit amet consectetur adipiscing elit sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident sunt in culpa qui officia deserunt mollit anim id est laborum.',
      imageUrl:
          'https://dep.com.vn/wp-content/uploads/2018/10/batch_mysoultokeeppbc-1.jpg',
    ),
    Novel(
      title: 'Novel 2',
      author: 'Author 2',
      chapters: 20,
      description: 'Description of Novel 2',
      imageUrl:
          'https://dep.com.vn/wp-content/uploads/2018/10/batch_mysoultokeeppbc-1.jpg',
    ),
    Novel(
      title: 'Novel 3',
      author: 'Author 3',
      chapters: 30,
      description: 'Description of Novel 3',
      imageUrl:
          'https://dep.com.vn/wp-content/uploads/2018/10/batch_mysoultokeeppbc-1.jpg',
    ),
    Novel(
      title: 'Novel 4',
      author: 'Author 4',
      chapters: 40,
      description: 'Description of Novel 4',
      imageUrl:
          'https://dep.com.vn/wp-content/uploads/2018/10/batch_mysoultokeeppbc-1.jpg',
    ),
    Novel(
      title: 'Novel 5',
      author: 'Author 5',
      chapters: 50,
      description: 'Description of Novel 5',
      imageUrl:
          'https://dep.com.vn/wp-content/uploads/2018/10/batch_mysoultokeeppbc-1.jpg',
    ),
    Novel(
      title: 'Novel 6',
      author: 'Author 6',
      chapters: 60,
      description: 'Description of Novel 6',
      imageUrl:
          'https://dep.com.vn/wp-content/uploads/2018/10/batch_mysoultokeeppbc-1.jpg',
    ),
    Novel(
      title: 'Novel 7',
      author: 'Author 7',
      chapters: 70,
      description: 'Description of Novel 7',
      imageUrl:
          'https://dep.com.vn/wp-content/uploads/2018/10/batch_mysoultokeeppbc-1.jpg',
    ),
    Novel(
      title: 'Novel 8',
      author: 'Author 8',
      chapters: 80,
      description: 'Description of Novel 8',
      imageUrl:
          'https://dep.com.vn/wp-content/uploads/2018/10/batch_mysoultokeeppbc-1.jpg',
    ),
    Novel(
      title: 'Novel 9',
      author: 'Author 9',
      chapters: 90,
      description: 'Description of Novel 9',
      imageUrl:
          'https://dep.com.vn/wp-content/uploads/2018/10/batch_mysoultokeeppbc-1.jpg',
    ),
    Novel(
      title: 'Novel 10',
      author: 'Author 10',
      chapters: 100,
      description: 'Description of Novel 10',
      imageUrl:
          'https://dep.com.vn/wp-content/uploads/2018/10/batch_mysoultokeeppbc-1.jpg',
    ),
  ];

  int get novelsCount => novels.length;

  List<Novel> getNovels() {
    return novels;
  }
}
