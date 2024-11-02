import 'package:pocketbase/pocketbase.dart';

import '../models/chapter.dart';

import 'pocketbase_client.dart';

class ChapterService {
  Future<List<Chapter>> fetchChapters(String novelId) async {
    final List<Chapter> chapters = [];

    try {
      final pb = await getPocketBaseInstance();
      final chapterModels = await pb.collection('chapter').getFullList(
            filter: 'novel = "$novelId"',
          );

      for (final chapterModel in chapterModels) {
        chapters.add(Chapter.fromJson(chapterModel.toJson()));
      }

      return chapters;
    } catch (error) {
      return chapters;
    }
  }

  // Future<Chapter?> addChapter(Chapter chapter) async {
  //   try {
  //     final pb = await getPocketBaseInstance();
  //     final chapterModel =
  //         await pb.collection('chapters').create(chapter.toJson());
  //     return Chapter.fromJson(chapterModel.toJson());
  //   } catch (error) {
  //     return null;
  //   }
  // }
}
