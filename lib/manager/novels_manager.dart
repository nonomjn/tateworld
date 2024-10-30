import '../models/novel.dart';

class NovelsManager {
  final List<Novel> novels = [
    Novel(
      title: 'Lạc trong mơ',
      author: 'Author 1',
      chapters: 2000,
      views: 2342,
      progress: 0.8,
      rating: 4.5,
      description:
          'Lạc trong mơ là một câu chuyện xoay quanh những cung bậc cảm xúc và khát khao khám phá thế giới ẩn giấu trong chính tiềm thức con người. Câu chuyện kể về một nhân vật chính bị mắc kẹt giữa ranh giới của thực tại và những giấc mơ kỳ ảo, nơi mà ranh giới giữa thực và ảo trở nên mờ nhạt. Mỗi giấc mơ lại mở ra một hành trình mới, đầy bí ẩn và thách thức, đưa nhân vật chính dấn thân vào cuộc phiêu lưu vượt ra ngoài những giới hạn thông thường.',
      imageUrl:
          'https://i.pinimg.com/564x/8e/20/e3/8e20e3e547ee81c75abf02f180d8a622.jpg',
    ),
    Novel(
      title: 'Quỷ bí chi chủ',
      author: 'Author 2',
      chapters: 1001,
      views: 3102,
      progress: 0.6,
      rating: 4.0,
      description: 'Description of Novel 2',
      imageUrl:
          'https://i.pinimg.com/enabled_hi/564x/15/fc/89/15fc89d28e5835c97403e8e84a69ef0e.jpg',
    ),
    Novel(
      title: 'Shadow of the Wind',
      author: 'Author 3',
      chapters: 800,
      views: 5300,
      progress: 0.9,
      rating: 4.8,
      description: 'Description of Novel 3',
      imageUrl:
          'https://i.pinimg.com/enabled_hi/564x/6a/6c/06/6a6c069505e5d71bf2aeeec9f2de1ca5.jpg',
    ),
    Novel(
      title: 'Lam',
      author: 'Author 4',
      chapters: 10000,
      views: 7802,
      progress: 0.7,
      rating: 4.2,
      description: 'Description of Novel 4',
      imageUrl:
          'https://i.pinimg.com/564x/e8/43/64/e84364482284f39f79cc2b39d02890d9.jpg',
    ),
    Novel(
      title: 'Địa phủ',
      author: 'Author 5',
      chapters: 5000,
      views: 8493,
      progress: 0.5,
      rating: 4.7,
      description: 'Description of Novel 5',
      imageUrl:
          'https://i.pinimg.com/564x/b5/f1/01/b5f1011cd54f9794e4e03c34e9c29748.jpg',
    ),
  ];

  int get novelsCount => novels.length;

  List<Novel> getNovels() {
    return novels;
  }
}
