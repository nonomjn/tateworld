import 'package:pocketbase/pocketbase.dart';

import '../models/novel.dart';

import 'pocketbase_client.dart';

class NovelService {
  String _getImageCover(PocketBase pb, RecordModel novelModel) {
    final imageCover = novelModel.getStringValue('image_cover');
    return pb.files.getUrl(novelModel, imageCover).toString();
  }

  Future<List<Novel>> fetchNovels() async {
    final List<Novel> novels = [];

    try {
      final pb = await getPocketBaseInstance();
      final novelModels = await pb.collection('novels').getFullList();

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
}
