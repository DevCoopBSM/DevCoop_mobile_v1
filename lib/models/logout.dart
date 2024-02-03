import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> _logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove('accToken');
  prefs.remove('refToken');
  prefs.remove('clientName');
  prefs.remove('userPoint');
  print("removed userData");
}
