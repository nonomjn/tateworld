import 'package:flutter/foundation.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';
import '../../services/follow_service.dart';

class UserManager with ChangeNotifier {
  final UserService _userService = UserService();
  final List<User> _users = [];
  final Map<String, List<User>> _followers = {};

  List<User> get users => _users;

  List<User> getFollowersForUser(String userId) {
    return _followers[userId] ?? [];
  }

  Future<void> getFollowing(User user) async {
    _users.clear();
    final following = await FollowService().getFollowing(user);
    for (final id in following['following']) {
      final followingUser = await _userService.getUserbyId(id);
      _users.add(followingUser);
    }
    notifyListeners();
  }

  Future<void> fetchFollowers(User user) async {
    if (user.id == null || _followers.containsKey(user.id!)) return;
    _followers[user.id!] = [];
    final followerIds = await FollowService().getFollowers(user);
    for (final id in followerIds) {
      final follower = await _userService.getUserbyId(id);
      _followers[user.id]!.add(follower);
    }
    notifyListeners();
  }

  User? getUserById(String id) {
    if (_users.isEmpty) return null;
    return _users.firstWhere((user) => user.id == id);
  }

  Future<User?> addUser(String userId) async {
    final existingUser = getUserById(userId);
    if (existingUser != null) {
      return existingUser;
    }

    final user = await _userService.getUserbyId(userId);
    _users.add(user);
    notifyListeners();
    return user; // Return the fetched user
  }
}
