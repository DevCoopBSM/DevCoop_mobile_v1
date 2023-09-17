import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aripay/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(initialLoggedInState: false), // 초기에 로그인되지 않은 상태로 설정
    );
  }
}

class LoginPage extends StatefulWidget {
  bool initialLoggedInState; // initialLoggedInState 속성을 추가

  LoginPage({Key? key, required this.initialLoggedInState}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}


class _LoginPageState extends State<LoginPage> {
  // final String apiUrl = 'http://10.10.0.11:6002/DevCoop_Back/api/login';
  // final String apiUrl = 'http://DevCoop_Back/api/login';
  // final String apiUrl = 'http://DevCoop_Back:6002/api/login';
  // final String apiUrl = 'http://10.10.0.11:6002/api/login';
  final String apiUrl = "http://10.129.57.5:6002/api/login";

  final TextEditingController userEmailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String responseText = "";
  String accToken = '';
  String refToken = '';
  String clientName = '';
  int userPoint = 0;

  // 액세스 토큰을 저장하는 메서드
  Future<void> saveAccessToken(String token) async {
    try {
      if (accToken != null && accToken is String) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(accToken, token);
      }
    } catch(e) {
      print(e);
    }
  }

  Future<void> saveRefreshToken(String token) async {
    try {
      if (refToken != null && refToken is String) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(refToken, token);
      }
    } catch(e) {
      print(e);
    }
  }

  Future<void> saveClientName(String name) async {
    try {
      if (clientName != null && clientName is String) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(clientName, name);
      }
    } catch(e) {
      print(e);
    }
  }

  Future<void> saveUserPoint(int point) async {
    try {
      int userPoint = point; // 포인트를 안전하게 int로 파싱
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setInt('userPoint', userPoint); // 포인트를 'userPoint' 키로 저장
    } catch(e) {
      print(e);
    }
  }

  Future<void> _login(BuildContext context) async {
    String userEmail = userEmailController.text;
    String password = passwordController.text;

    print("login button was clicked");

    Map<String, dynamic> requestData = {
      'email': userEmail,
      'password': password,
    };
    String jsonData = json.encode(requestData);

    print(jsonData);

    try {
      print(apiUrl);
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData,
      );
      print(response);

      if (response.statusCode == 200) {
        print("success!");
        setState(() {
          responseText = "로그인 성공: ${response.body}";
          final jsonResponse = json.decode(response.body);
          print(jsonResponse);
          // JSON에서 토큰 추출
          final String accessToken = jsonResponse['accToken'];
          final String refreshToken = jsonResponse['refToken'];
          print(accessToken);
          // JSON에서 사용자 이름 추출
          final String name = jsonResponse['name'];
          print(name);

          // JSON에서 point 추출
         int userPoint = jsonResponse['point'];

          // 액세스 토큰을 저장합니다.
          saveAccessToken(accessToken);
          saveRefreshToken(refreshToken);

          // 사용자 이름을 저장합니다
          saveClientName(name);

          // 사용자 point를 저장합니다
          saveUserPoint(userPoint);

          widget.initialLoggedInState = true;
        });

        // 로그인 성공 시에는 Navigator를 사용하여 다음 화면으로 이동
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(initialLoggedInState: widget.initialLoggedInState),
          ),
        );
      } else {
        setState(() {
          responseText = "로그인 실패: ${response.statusCode}";
          print("failed");
        });
      }
    } catch (e) {
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
                  hintText: 'Enter your Password',
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
