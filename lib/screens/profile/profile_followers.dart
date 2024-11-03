import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/user.dart';
import '../../manager/user_manager.dart';

class ProfileFollowers extends StatelessWidget {
  final User user;
  const ProfileFollowers({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Danh sách người theo dõi',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 100,
            child: FutureBuilder(
              future: context
                  .read<UserManager>()
                  .getfollowers(user), // Sử dụng Provider
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Center(child: Text('Có lỗi xảy ra'));
                }
                final followers = context.watch<UserManager>().users;
                print(followers.length);

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: followers.length,
                  itemBuilder: (context, index) {
                    final follow = followers[index];
                    return Card(
                      child: SizedBox(
                        width: 100,
                        child:
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/profile', arguments: follow.id);
                          },
                          child:
                         Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                follow.url_avatar ??
                                    'https://as-rays.pockethost.io/api/files/_pb_users_auth_/ttsp8nwp1dv3ljk/con_duong_ba_chu_cover_large_aKmK5tfyR1.jpg?token=',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              follow.name,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
