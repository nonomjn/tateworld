import '../models/chapter.dart';

import 'pocketbase_client.dart';

class ChapterService {
  Future<List<Chapter>> fetchChapters(String novelId,
      {bool isDraft = false, bool isPublished = false}) async {
    final List<Chapter> chapters = [];

    try {
      final pb = await getPocketBaseInstance();

      final List<String> filters = ['novel = "$novelId"'];

      if (isDraft) {
        filters.add('status = "draft"');
      }

      if (isPublished) {
        filters.add('status = "published"');
      }

      final filterQuery = filters.join(' && ');

      final chapterModels = await pb.collection('chapter').getFullList(
            filter: filterQuery,
          );

      for (final chapterModel in chapterModels) {
        chapters.add(Chapter.fromJson(chapterModel.toJson()));
      }
      return chapters;
    } catch (error) {
      return chapters;
    }
  }

  Future<Chapter?> fetchChapter(String chapterId) async {
    try {
      final pb = await getPocketBaseInstance();
      final chapterModel = await pb.collection('chapter').getOne(chapterId);
      return Chapter.fromJson(chapterModel.toJson());
    } catch (error) {
      return null;
    }
  }

  Future<void> incrementViewCount(String chapterId) async {
    try {
      final pb = await getPocketBaseInstance();
      final chapterModel = await pb.collection('chapter').getOne(chapterId);
      final currentViews = chapterModel.data['count_view'] ?? 0;
      await pb
          .collection('chapter')
          .update(chapterId, body: {'count_view': currentViews + 1});
    } catch (error) {
      print("Error occurred: $error");
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
