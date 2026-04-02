import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getUID() async {
  SharedPreferences db = await SharedPreferences.getInstance();
  return db.getString("uid");
}

Future<void> setUID(String uid) async {
  SharedPreferences db = await SharedPreferences.getInstance();
  await db.setString("uid", uid);
}

Future<void> deleteUID() async {
  SharedPreferences db = await SharedPreferences.getInstance();
  await db.remove("uid");
}
