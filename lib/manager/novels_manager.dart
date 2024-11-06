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

  // Future<void> fetchNovelByUser() async {
  //   _novels = await _novelService.fetchNovel(filteredByUser: true);
  //   notifyListeners();
  // }

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

  Novel? getNovelById(String id) {
    return _novels.firstWhere((novel) => novel.id == id);
  }

  Future<void> fetchNovelByIdAndReplace(String id) async {
    final novel = await _novelService.fetchNovelById(id);
    if (novel != null) {
      final index = _novels.indexWhere((novel) => novel.id == id);
      if (index != -1) {
        _novels[index] = novel;
        notifyListeners();
      }
      notifyListeners();
    }
  }
}
