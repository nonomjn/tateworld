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
    _novels = await _novelService.fetchNovelLatest();
    notifyListeners();
  }
}
