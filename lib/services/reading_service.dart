import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/reading.dart';

import 'pocketbase_client.dart';

class ReadingService {
  Future<List<Reading>> fetchReadingNovel() async {
    final List<Reading> reading = [];

    try {
      final pb = await getPocketBaseInstance();
      final userId = pb.authStore.model!.id;

      final readingModels = await pb.collection('reading_status').getFullList(
            filter: "user = '$userId'",
            expand: "chapter, chapter.novel, chapter.novel.chapter_via_novel",
          );

      for (final readingModel in readingModels) {
        final readingJson = readingModel.toJson();
        final chapterJson =
            readingJson['expand']?['chapter'] as Map<String, dynamic>?;
        final novelJson =
            chapterJson?['expand']?['novel'] as Map<String, dynamic>?;

        String? imageCover;
        imageCover = novelJson?['image_cover'] as String?;
        if (novelJson != null && novelJson['image_cover'] != null) {
          imageCover = "${dotenv.env['POCKETBASE_URL']}/api/files/"
              "${novelJson['collectionId']}/${novelJson['id']}/${novelJson['image_cover']}";
          novelJson['image_cover'] = imageCover;
        }

        int totalChaptersPublished = 0;
        int totalViews = 0;

        final chapters =
            novelJson?['expand']?['chapter_via_novel'] as List<dynamic>?;
        if (chapters != null) {
          for (final chapter in chapters) {
            final chapterStatus = chapter['status'] as String?;
            final chapterViews = chapter['count_view'] as int? ?? 0;

            if (chapterStatus == 'published') {
              totalChaptersPublished++;
            }

            totalViews += chapterViews;
          }
        }

        novelJson?['totalChaptersPublished'] = totalChaptersPublished;
        novelJson?['totalViews'] = totalViews;

        reading.add(Reading.fromJson(
          readingJson
            ..['expand'] = {
              'chapter': chapterJson,
              'novel': novelJson,
            },
        ));
      }
    } catch (e) {
      print(e);
    }

    return reading;
  }
}
