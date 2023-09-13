import 'package:flutter/material.dart';
import 'package:aripay/login.dart';

void main() => runApp(
  MaterialApp(
    home: UserLog(),
  ),
);

class UserLog extends StatefulWidget {
  @override
  _UserLogState createState() => _UserLogState();
}

class _UserLogState extends State<UserLog> {
  bool isLoggedIn = true;

  // 로그아웃 처리 함수
  void _handleLogout() {
    // 여기에서 로그아웃 로직을 구현하세요.
    // 예를 들어, 사용자 인증 토큰을 삭제하거나 로그아웃 API를 호출할 수 있습니다.

    // 사용자 로그아웃 상태로 변경
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/AriPayL_ver2.png",
                width: 100,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (isLoggedIn) {
                  _handleLogout(); // 로그아웃 함수 호출
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                }
              },
              child: Text(
                isLoggedIn ? "로그아웃" : "로그인",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        body: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 30, left: 15),
              child: Text(
                "남은 금액",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black45
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: 30, left: 220),
              child: Text(
                "9000" + "원",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
