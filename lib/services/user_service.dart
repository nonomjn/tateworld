import 'package:pocketbase/pocketbase.dart';

class UserService {
  String _getAvatar(PocketBase pb, RecordModel userModel) {
    final avatar = userModel.getStringValue('avatar');
    return pb.files.getUrl(userModel, avatar).toString();
  }
}
