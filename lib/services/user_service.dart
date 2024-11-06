import 'package:pocketbase/pocketbase.dart';

import '../models/user.dart';
import './pocketbase_client.dart';

class UserService {
String _getAvatarImageUrl(PocketBase pb, RecordModel usermodel) {
    final avatarImageName = usermodel.getStringValue('avatar');
    return pb.files.getUrl(usermodel, avatarImageName).toString();
  }

  String _getCoverImageUrl(PocketBase pb, RecordModel usermodel) {
    final coverImageName = usermodel.getStringValue('cover');
    return pb.files.getUrl(usermodel, coverImageName).toString();
  }
  Future<User> getUserbyId(String userId) async {
    try {
       userId = userId.replaceAll(RegExp(r'\[|\]'), '');
      final pb = await getPocketBaseInstance();
      final record = await pb.collection('users').getOne(userId);
      return User.fromJson(record.toJson()..addAll({
        'url_avatar': _getAvatarImageUrl(pb, record),
        'url_cover': _getCoverImageUrl(pb, record),
      }));
    } catch (error) {
      print('Error getting user by id: $error');
      throw Exception('An error occurred');
    }
  }
}
