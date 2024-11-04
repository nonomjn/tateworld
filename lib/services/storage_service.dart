import 'package:pocketbase/pocketbase.dart';

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
            expand: "novel",
          );
      print(storageModels);

      for (final storageModel in storageModels) {
        storage.add(Storage.fromJson(storageModel.toJson()));
      }
      return storage;
    } catch (e) {
      return storage;
    }
  }
}
