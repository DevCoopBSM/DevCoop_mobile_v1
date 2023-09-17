import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aripay/login.dart';
import 'package:aripay/chargeUserLog.dart';
import 'package:aripay/useUserLog.dart';
import 'package:shared_preferences/shared_preferences.dart';

final String accessTokenKey = 'accToken';
final String refreshTokenKey = 'refToken';
final String userPointKey = 'userPoint';

void main() => runApp(
  MaterialApp(
    home: MyApp(initialLoggedInState: false),
  ),
);

class MyApp extends StatefulWidget {
  final bool initialLoggedInState;

  MyApp({required this.initialLoggedInState});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  int? userPoint;

  @override
  void initState() {
    super.initState();
    isLoggedIn = widget.initialLoggedInState;
    loadSavedData();
  }

  // 사용자 로그인 또는 로그아웃 상태를 업데이트하는 함수
  void updateLoginStatus(bool status) {
    setState(() {
      isLoggedIn = status;
    });
  }

  Future<int?> loadUserPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userPoint = prefs.getInt(userPointKey);
    return userPoint;
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? accessToken = prefs.getString(accessTokenKey);
    if (accessToken != null) {
      print('액세스 토큰: $accessToken');
    } else {
      print('저장된 액세스 토큰이 없습니다.');
    }

    String? refreshToken = prefs.getString(refreshTokenKey);
    if (refreshToken != null) {
      print('리프레시 토큰: $refreshToken');
    } else {
      print('저장된 리프레시 토큰이 없습니다.');
    }

    int? userPoint = await loadUserPoint();
    if (userPoint != null) {
      setState(() {
        this.userPoint = userPoint;
      });
      print('사용자 포인트: $userPoint');
    } else {
      print('저장된 사용자 포인트가 없습니다.');
    }
  }

  void _launchNotion() async {
    const String notionUrl =
        "https://www.notion.so/dev-coop/061a8cc3efc54f8a9813f065b5f66140";

    if (await canLaunch(notionUrl)) {
      await launch(notionUrl);
    } else {
      throw 'Could not launch $notionUrl';
    }
  }

  void _launchInsta() async {
    const String instaUrl = 'https://www.instagram.com/bsm_devcoop';
    if (await canLaunch(instaUrl)) {
      await launch(instaUrl);
    } else {
      throw 'Could not launch $instaUrl';
    }
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(accessTokenKey); // 수정: 'accToken' 대신 변수 사용
    print("removed accToken");

    setState(() {
      isLoggedIn = !isLoggedIn; // 로그인 상태를 변경
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
                isLoggedIn ? _logout(context) :
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginApp()),
                );
              },
              child: Text(
                isLoggedIn ? "로그아웃" : "로그인", // 로그인 상태에 따라 버튼 텍스트 변경
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
                    margin: EdgeInsets.only(left: 10, right: 155, top: 40),
                    child: Text(
                      "현재 사용가능한 금액",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    margin: isLoggedIn
                        ? EdgeInsets.only(left: 30, right: 220, top: 30)
                        : EdgeInsets.only(left: 10, right: 85, top: 30),
                    width: 200,
                    child: Text(
                      isLoggedIn
                          ? "${userPoint ?? null}원"
                          : "로그인을 해주세요",
                      style: TextStyle(
                        fontSize: 26,
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
                          margin: EdgeInsets.only(top: 30, left: 20),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChargeUserLog(
                                    isLoggedIn: isLoggedIn, // isLoggedIn 전달
                                    updateLoginStatus: updateLoginStatus, // updateLoginStatus 전달
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              "충전내역 〉",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30, left: 135),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UseUserLog(
                                  isLoggedIn: isLoggedIn, // isLoggedIn 전달
                                  updateLoginStatus: updateLoginStatus, // updateLoginStatus 전달
                                ),
                              ),
                            );
                          },
                          child: Text(
                            "결제내역 〉",
                            style: TextStyle(
                              fontSize: 14,
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
