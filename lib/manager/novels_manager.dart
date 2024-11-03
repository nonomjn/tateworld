import 'package:flutter/material.dart';

import '../models/novel.dart';
import '../services/novel_service.dart';

class NovelsManager with ChangeNotifier {
  final NovelService _novelService = NovelService();

  List<Novel> _novels = [];

  int get novelsCount => _novels.length;

  List<Novel> getNovels() {
    return [..._novels];
  }

  Future<void> fetchNovelLates() async {
    _novels = await _novelService.fetchNovel();
    notifyListeners();
  }

  Future<void> fetchNovelByUser() async {
    _novels = await _novelService.fetchNovel(filteredByUser: true);
    notifyListeners();
  }

  Future<void> fetchDraftNovel() async {
    _novels =
        await _novelService.fetchNovel(filteredByUser: true, isDraft: true);
    notifyListeners();
  }

  Future<void> fetchCompleteNovel() async {
    _novels =
        await _novelService.fetchNovel(filteredByUser: true, isComplete: true);
    notifyListeners();
  }
}
