import 'package:developers/main.dart';
import 'package:zeytin/zeytin.dart';

class UsersDatabase {
  static List<ZeytinUserModel> users = [];
  static Future<void> getUser() async {
    users = await ZeytinUser(zeytin).getAllProfile();
  }

  static ZeytinUserModel? getUserWithUID({required String uid}) {
    bool isContain = cacheUsers.any((element) => uid == element.uid);
    if (isContain) {
      int index = cacheUsers.indexWhere((element) => uid == element.uid);
      var user = cacheUsers[index];
      return user;
    } else {
      if (users.any((element) => element.uid == uid)) {
        return users.firstWhere((element) => element.uid == uid);
      } else {
        return null;
      }
    }
  }
}
