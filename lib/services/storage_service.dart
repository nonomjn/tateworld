import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/storage.dart';

import 'pocketbase_client.dart';

class StorageService {
  Future<List<Storage>> fetchStorage() async {
    final List<Storage> storage = [];

    try {
      final pb = await getPocketBaseInstance();
      final userId = pb.authStore.model!.id;

      final storageModels = await pb.collection('storage').getFullList(
            filter: "user = '$userId'",
            expand: "novel, novel.chapter_via_novel",
          );

      for (final storageModel in storageModels) {
        final storageJson = storageModel.toJson();
        final novelJson =
            storageJson['expand']?['novel'] as Map<String, dynamic>?;

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

        storage.add(Storage.fromJson(
          storageJson
            ..['expand'] = {
              'novel': novelJson,
            },
        ));
      }

      return storage;
    } catch (e) {
      return storage;
    }
  }
}
