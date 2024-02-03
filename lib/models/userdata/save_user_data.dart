import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveAccessToken(String token) async {
  try {
    if (token != "" && token.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('accToken', token);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> saveRefreshToken(String token) async {
  try {
    if (token != "" && token.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('refToken', token);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> saveClientName(String name) async {
  try {
    if (name != null && name.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('clientName', name);
    }
  } catch (e) {
    print(e);
  }
}

Future<void> saveUserPoint(int point) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userPoint', point);
  } catch (e) {
    print(e);
  }
}
