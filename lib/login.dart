import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aripay/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'dart:io';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(initialLoggedInState: false),
    );
  }
}

class LoginPage extends StatefulWidget {
  bool initialLoggedInState;

  LoginPage({Key? key, required this.initialLoggedInState}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String apiUrl = "http://10.129.57.5/api/login";

  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String responseText = "";
  String accToken = '';
  String refToken = '';
  String clientName = '';
  int userPoint = 0;

  Future<void> saveAccessToken(String token) async {
    try {
      if (token != null && token.isNotEmpty) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('accToken', token);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveRefreshToken(String token) async {
    try {
      if (token != null && token.isNotEmpty) {
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

  CookieJar cookieJar = CookieJar();

  Future<void> _login(BuildContext context) async {
    String userEmail = userEmailController.text;
    String password = passwordController.text;

    Map<String, dynamic> requestData = {
      'email': userEmail,
      'password': password,
    };
    String jsonData = json.encode(requestData);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );

      if (response.statusCode == 200) {
        print("로그인 성공!");
        print(response.headers);
        print(response.headers['set-cookie']);

        // 쿠키 추출 및 저장
        String? setCookieHeader = response.headers['set-cookie'];
        if (setCookieHeader != null) {
          List<String> cookies = setCookieHeader.split(';');
          for (String cookie in cookies) {
            if (cookie.contains('accessToken')) {
              final cookieParts = cookie.split('=');
              final cookieName = cookieParts[0].trim();
              final cookieValue = cookieParts[1].trim();
              print(cookieValue);
              print(cookieName);
              await saveAccessToken(cookieValue);
            } else if (cookie.contains('refreshToken')) {
              final cookieParts = cookie.split('=');
              final cookieName = cookieParts[0].trim();
              final cookieValue = cookieParts[1].trim();
              print(cookieValue);
              print(cookieName);
              await saveRefreshToken(cookieValue);
            }
            // cookie stirng 문자열 안에 accessToken or refreshToken이 포함되어 있으면 추출
          }
        }

        setState(() {
          responseText = "로그인 성공: ${response.body}";
          final jsonResponse = json.decode(response.body);
          // print(jsonResponse);
          // final String accessToken = jsonResponse['accToken'];
          // final String refreshToken = jsonResponse['refToken'];
          final String name = jsonResponse['name'];
          int userPoint = jsonResponse['point'];
          // saveAccessToken(accessToken);
          // saveRefreshToken(refreshToken);
          saveClientName(name);
          saveUserPoint(userPoint);
          widget.initialLoggedInState = true;
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                MyApp(initialLoggedInState: widget.initialLoggedInState),
          ),
        );
      } else {
        setState(() {
          if (response.statusCode == null) {
            responseText = "로그인 실패: 응답 상태 코드 없음";
          } else {
            responseText = "로그인 실패: ${response.statusCode}";
          }
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        responseText = "오류 발생: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(80),
            ),
            Container(
              margin: EdgeInsets.all(30),
              child: Image.asset(
                "assets/AriPayL.png",
                fit: BoxFit.cover,
                width: 100,
              ),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                controller: userEmailController,
                decoration: InputDecoration(
                  labelText: '이메일 입력해주세요',
                  hintText: '학교 이메일을 입력해주세요',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.black12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
            ),
            SizedBox(
              width: 300,
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: '비밀번호를 입력해주세요',
                  hintText: '비밀번호 입력',
                  labelStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(width: 1, color: Colors.black12),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
            ),
            ElevatedButton(
              onPressed: () {
                _login(context);
              },
              child: Text("로그인"),
              style: ElevatedButton.styleFrom(
                primary: Colors.yellow,
                onPrimary: Colors.black,
                minimumSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 2,
                shadowColor: Colors.grey,
                textStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Text(
                "학교 이메일(@bssm.hs.kr)로만 로그인이 가능합니다",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 13,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Text(
                responseText,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
