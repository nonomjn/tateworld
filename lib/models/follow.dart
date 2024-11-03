import 'dart:io';

import 'user.dart';

class follow {
  User follower;
  User following;
  follow({
    required this.follower,
    required this.following,
  });
  follow copyWith({
    User? follower,
    User? following,
  }) {
    return follow(
      follower: follower ?? this.follower,
      following: following ?? this.following,
    );
  }

}
