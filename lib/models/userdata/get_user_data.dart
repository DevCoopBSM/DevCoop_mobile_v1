import 'package:aripay/models/userpoint/get_user_point.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> loadSavedData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? accessToken = prefs.getString('accToken');
  if (accessToken != null) {
    print('액세스 토큰: $accessToken');
  } else {
    print('저장된 액세스 토큰이 없습니다.');
  }

  String? refreshToken = prefs.getString('refToken');
  if (refreshToken != null) {
    print('리프레시 토큰: $refreshToken');
  } else {
    print('저장된 리프레시 토큰이 없습니다.');
  }

  int? userPoint = await loadUserPoint();
  if (userPoint != null) {
    print('사용자 포인트: $userPoint');
  } else {
    print('저장된 사용자 포인트가 없습니다.');
  }
}
