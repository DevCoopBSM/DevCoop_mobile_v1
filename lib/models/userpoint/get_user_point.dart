import 'package:shared_preferences/shared_preferences.dart';

Future<int?> loadUserPoint() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int? userPoint = prefs.getInt('userPoint');
  return userPoint;
}
