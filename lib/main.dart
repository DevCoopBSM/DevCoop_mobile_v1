import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aripay/login.dart';
import 'package:aripay/chargeUserLog.dart';
import 'package:aripay/useUserLog.dart';

void main() => runApp(
  MaterialApp(
    home: MyApp(),
  ),
);

class MyApp extends StatefulWidget {
  const MyApp({Key? key});
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // 외부 URL
  final String notionUrl = "https://www.notion.so/dev-coop/061a8cc3efc54f8a9813f065b5f66140";
  final String instaUrl = 'https://www.instagram.com/bsm_devcoop';

  bool isLoggedIn = false; // 로그인 상태를 관리할 변수

  // 클릭 이벤트 처리
  void _launchNotion() async {
    if (await canLaunch(notionUrl)) {
      await launch(notionUrl);
    } else {
      throw 'Could not launch $notionUrl';
    }
  }

  void _launchInsta() async {
    if (await canLaunch(instaUrl)) {
      await launch(instaUrl);
    } else {
      throw 'Could not launch $instaUrl';
    }
  }

  // 로그아웃 처리 함수
  void _handleLogout() {
    // 여기에서 로그아웃 로직을 구현하세요.
    // 사용자 로그아웃 상태로 변경
    setState(() {
      isLoggedIn = false;
    });
  }

  // 사용자 포인트 받아오는 API URL
  // 'http://10.129.57.5:6002/api/studentinfo'

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
        body: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color.fromRGBO(65, 67, 76, 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              width: 400,
              height: 180,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 140, top: 40),
                    child: Text(
                      "현재 사용가능한 금액 〉",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: isLoggedIn ? EdgeInsets.only(left: 10, right: 130, top: 30) : EdgeInsets.only(left: 10, right: 35, top: 30),
                    child: Text(
                      isLoggedIn ? "남은금액 : " : "로그인을 해주세요",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(top: 30, left: 20), // 첫 번째 버튼 마진 설정
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChargeUserLog()), // UserLog 페이지로 이동
                              );
                            },
                            child: Text(
                              "충전내역 〉",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 135), // 첫 번째 버튼 마진 설정
                        child: TextButton(
                          onPressed: () {
                            // 두 번째 버튼의 동작 정의
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => UseUserLog()), // UserLog 페이지로 이동
                            );
                          },
                          child: Text(
                            "결제내역 〉",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: Color.fromRGBO(52, 52, 60, 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(2, 4),
                  ),
                ],
              ),
              width: 400,
              height: 100,
            ),
            GestureDetector(
                onTap: _launchInsta,
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/aripay.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 20,
                      left: 30,
                      child: Text(
                        "문의하기",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Colors.lightBlue,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                width: 400,
                height: 150,
              ),
            ),
            GestureDetector(
              onTap: _launchNotion,
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color.fromRGBO(240, 206, 0, 1.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: Offset(2, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    "How\nTo\nUse",
                    style: TextStyle(
                      fontSize: 40.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 2.0,
                      wordSpacing: 5.0,
                      decorationColor: Colors.red,
                    ),
                  ),
                ),
                width: 400,
                height: 150,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
