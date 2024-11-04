import 'package:flutter/material.dart';

import '../models/storage.dart';
import '../services/storage_service.dart';

class StorageManager with ChangeNotifier {
  final StorageService _storageService = StorageService();

  List<Storage> _storage = [];

  int get storageCount => _storage.length;

  List<Storage> getStorage() {
    return [..._storage];
  }

  Future<void> fetchStorage() async {
    _storage = await _storageService.fetchStorage();
    notifyListeners();
  }
}
