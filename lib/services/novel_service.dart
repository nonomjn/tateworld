import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../models/novel.dart';

import 'pocketbase_client.dart';

class NovelService {
  String _getImageCover(PocketBase pb, RecordModel novelModel) {
    final imageCover = novelModel.getStringValue('image_cover');
    return pb.files.getUrl(novelModel, imageCover).toString();
  }

  Future<List<Novel>> fetchNovel({
    bool filteredByUser = false,
    bool isDraft = false,
    bool isComplete = false,
  }) async {
    final List<Novel> novels = [];

    try {
      final pb = await getPocketBaseInstance();
      final userId = pb.authStore.model!.id;
      final List<String> filters = [];

      if (filteredByUser) {
        filters.add("author = '$userId'");
      }

      if (isDraft) {
        filters.add('is_completed = false');
      }

      if (isComplete) {
        filters.add('is_completed = true');
      }

      final filterQuery = filters.isNotEmpty ? filters.join(' && ') : null;

      final novelModels = await pb.collection('novels').getFullList(
            filter: filterQuery,
            expand: 'chapters',
          );

      for (final novelModel in novelModels) {
        novels.add(Novel.fromJson(
          novelModel.toJson()
            ..addAll({
              'url_image_cover': _getImageCover(pb, novelModel),
            }),
        ));
      }

      return novels;
    } catch (error) {
      return novels;
    }
  }

  // Future<Novel?> addNovel(Novel novel) async {
  //   try {
  //     final pb = await getPocketBaseInstance();
  //     final novelModel = await pb.collection('novels').create(novel.toJson());
  //     return Novel.fromJson(
  //       novelModel.toJson()
  //         ..addAll({
  //           'url_image_cover': _getImageCover(pb, novelModel),
  //         }),
  //     );
  //   } catch (error) {
  //     return null;
  //   }
  // }
}
