import 'package:pocketbase/pocketbase.dart';

import 'package:http/http.dart' as http;
import '../models/user.dart';
import './pocketbase_client.dart';

class AuthService {
    String _getAvatarImageUrl(PocketBase pb, RecordModel usermodel) {
    final avatarImageName = usermodel.getStringValue('avatar');
    return pb.files.getUrl(usermodel, avatarImageName).toString();
  }

  String _getCoverImageUrl(PocketBase pb, RecordModel usermodel) {
    final coverImageName = usermodel.getStringValue('cover');
    return pb.files.getUrl(usermodel, coverImageName).toString();
  }
  void Function(User? user)? onAuthChange;
  AuthService({this.onAuthChange}) {
    if (onAuthChange != null) {
      getPocketBaseInstance().then((pb) {
        pb.authStore.onChange.listen((event) {
          onAuthChange!(event.model == null
              ? null
              : User.fromJson(event.model!.toJson()..addAll({
                  'url_avatar': _getAvatarImageUrl(pb, event.model!),
                  'url_cover': _getCoverImageUrl(pb, event.model!),
                })));
        });
      });
    }
  }
  Future<User> signup(String username, String password) async {
    final pb = await getPocketBaseInstance();
    try {
      final record = await pb.collection('users').create(body: {
        'username': username,
        'password': password,
        'passwordConfirm': password,
      });
      return User.fromJson(record.toJson());
    } catch (error) {
      if (error is ClientException) {
        throw Exception(error.response['message']);
      }
      throw Exception('An error occurred');
    }
  }

  Future<User> login(String username, String password) async {
    final pb = await getPocketBaseInstance();
    try {
      print('username: $username');
      final authRecord =
          await pb.collection('users').authWithPassword(username, password);
        print('authRecord: $authRecord');
      return User.fromJson(authRecord.record!.toJson()..addAll({
        'url_avatar': _getAvatarImageUrl(pb, authRecord.record!),
        'url_cover': _getCoverImageUrl(pb, authRecord.record!),
      }));
    } catch (error) {
      if (error is ClientException) {
        throw Exception(error.response['message']);
      }
      throw Exception('An error occurred');
    }
  }

  Future<void> logout() async {
    final pb = await getPocketBaseInstance();
    pb.authStore.clear();
  }

  Future<User?> getUserFromStore() async {
    final pb = await getPocketBaseInstance();
    final model = pb.authStore.model;
    if (model == null) {
      return null;
    }
    return User.fromJson(model.toJson()..addAll({
      'url_avatar': _getAvatarImageUrl(pb, model),
      'url_cover': _getCoverImageUrl(pb, model),
    }));
  }

  Future<User> updateProfile(User user) async {
    final pb = await getPocketBaseInstance();
    try {
      final record = await pb.collection('users').update(
        user.id!,
        body: user.toJson(),
        files: [
          if (user.avatar != null)
            await http.MultipartFile.fromBytes(
              'avatar',
              await user.avatar!.readAsBytes(),
              filename: user.url_avatar!.split('/').last,
            ),
          if (user.cover != null)
            await http.MultipartFile.fromBytes(
              'cover',
              await user.cover!.readAsBytes(),
              filename: user.url_cover!.split('/').last,
            ),
        ],
      );
      return user.copyWith(
        url_avatar: _getAvatarImageUrl(pb, record),
        url_cover: _getCoverImageUrl(pb, record),
      );
    } catch (error) {
      if (error is ClientException) {
        throw Exception(error.response['message']);
      }
      throw Exception('An error occurred');
    }
  }

  
}
