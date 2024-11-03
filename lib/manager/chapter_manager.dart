import 'package:flutter/foundation.dart';

import '../../models/chapter.dart';
import '../../services/chapter_service.dart';

class ChapterManager with ChangeNotifier {
  final ChapterService _chapterService = ChapterService();

  List<Chapter> _chapters = [];
  List<Chapter> get chapters => _chapters;

  int get totalViews {
    return _chapters.fold(0, (total, chapter) => total + chapter.count_view);
  }

  int get totalChapters {
    return _chapters.length;
  }

  int get totalChapterDrafts {
    return _chapters.where((chapter) => chapter.status == 'draft').length;
  }

  int get totalChapterPublished {
    return _chapters.where((chapter) => chapter.status == 'published').length;
  }

  Future<void> fetchChapters(String novelId) async {
    _chapters = await _chapterService.fetchChapters(novelId);
    notifyListeners();
  }

  Future<void> fetchDraftChapters(String novelId) async {
    _chapters = await _chapterService.fetchChapters(novelId, isDraft: true);
    notifyListeners();
  }

  Future<void> fetchPublishedChapters(String novelId) async {
    _chapters = await _chapterService.fetchChapters(novelId, isPublished: true);
    notifyListeners();
  }

  // Future<Chapter?> addChapter(Chapter chapter) async {
  //   final newChapter = await _chapterService.addChapter(chapter);
  //   if (newChapter != null) {
  //     _chapters.add(newChapter);
  //     notifyListeners();
  //   }
  //   return newChapter;
  // }
}
