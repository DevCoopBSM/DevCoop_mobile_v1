// import 'dart:convert';

// import '../../utils/configs/apis/api_config.dart';
// import '../userdata/save_user_data.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// Future<void> _login(BuildContext context) async {
//   String userEmail = userEmailController.text;
//   String password = passwordController.text;

//   Map<String, dynamic> requestData = {
//     'email': userEmail,
//     'password': password,
//   };
//   String jsonData = json.encode(requestData);

//   try {
//     final response = await http.post(
//       Uri.parse(defaultApiUrl),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonData,
//     );

//     if (response.statusCode == 200) {
//       print("로그인 성공!");
//       print(response.headers);
//       print(response.headers['set-cookie']);

//       // 쿠키 추출 및 저장
//       String? setCookieHeader = response.headers['set-cookie'];
//       if (setCookieHeader != null) {
//         List<String> cookies = setCookieHeader.split(';');
//         for (String cookie in cookies) {
//           if (cookie.contains('accessToken')) {
//             final cookieParts = cookie.split('=');
//             final cookieName = cookieParts[0].trim();
//             final cookieValue = cookieParts[1].trim();
//             print(cookieValue);
//             print(cookieName);
//             await saveAccessToken(cookieValue);
//           } else if (cookie.contains('refreshToken')) {
//             final cookieParts = cookie.split('=');
//             final cookieName = cookieParts[0].trim();
//             final cookieValue = cookieParts[1].trim();
//             print(cookieValue);
//             print(cookieName);
//             await saveRefreshToken(cookieValue);
//           }
//           // cookie stirng 문자열 안에 accessToken or refreshToken이 포함되어 있으면 추출
//         }
//       }

//       setState(() {
//         responseText = "로그인 성공: ${response.body}";
//         final jsonResponse = json.decode(response.body);
//         // print(jsonResponse);
//         // final String accessToken = jsonResponse['accToken'];
//         // final String refreshToken = jsonResponse['refToken'];
//         final String name = jsonResponse['name'];
//         int userPoint = jsonResponse['point'];
//         // saveAccessToken(accessToken);
//         // saveRefreshToken(refreshToken);
//         saveClientName(name);
//         saveUserPoint(userPoint);
//       });

//       Get.toNamed("/");
//     } else {
//       setState(() {
//         if (response.statusCode == null) {
//           responseText = "로그인 실패: 응답 상태 코드 없음";
//         } else {
//           responseText = "로그인 실패: ${response.statusCode}";
//         }
//       });
//     }
//   } catch (e) {
//     print(e);
//     setState(() {
//       responseText = "오류 발생: $e";
//     });
//   }
// }
