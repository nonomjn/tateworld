import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../models/user.dart';
import '../../services/user_service.dart';
import '../../services/follow_service.dart';

class UserManager with ChangeNotifier {
  late final UserService _userService;
  late List<User> _users;

  UserManager() {
    _userService = UserService();
    _users = [];
  }

  List<User> get users {
    return _users;
  }

  User getUserById(String id) {
    return _users.firstWhere((user) => user.id == id);
  }

  Future<void> getfollowing(User user) async {
    _users = [];
    final following = await FollowService().getFollowing(user);
    for (final id in following['following']) {
      final user = await _userService.getUserbyId(id);
      _users.add(user);
    }
    notifyListeners();
  }

  Future<void> getfollowers(User user) async {
    _users = [];
    final followers = await FollowService().getFollowers(user);
    for (final id in followers) {
      final user = await _userService.getUserbyId(id);
      _users.add(user);
      final url_avatar = user.url_avatar;
      print('url_avatar: $url_avatar');
    }
    notifyListeners();
  }
}