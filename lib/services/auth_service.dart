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
              : User.fromJson(event.model!.toJson()));
        });
      });
    }
  }
  Future<User> signup(User user, String password) async {
    final pb = await getPocketBaseInstance();
    try {
      print('user: ${user.toJson()}');
      print('password: $password');
      final record = await pb.collection('users').create(body: {
        ...user.toJson(),
        'password': password,
        'passwordConfirm': password,
      });
      print('record: ${record.toJson()}');
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
    return User.fromJson(model.toJson());
  }
}
