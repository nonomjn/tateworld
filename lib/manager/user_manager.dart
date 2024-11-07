import 'package:flutter/foundation.dart';
import '../../models/user.dart';
import '../../services/user_service.dart';

class UserManager with ChangeNotifier {
  final UserService _userService = UserService();
  final List<User> _users = [];

  List<User> get users => _users;

  User? getUserById(String id) {
    if (_users.isEmpty) return null;
    try {
      return _users.firstWhere((user) => user.id == id);
    } catch (e) {
      return null;
    }
  }


  Future<User?> addUser(String userId) async {
    final existingUser = getUserById(userId);
    if (existingUser != null) {
      return existingUser;
    }

    final user = await _userService.getUserbyId(userId);
    _users.add(user);
    notifyListeners();
    return user;
  }
}
