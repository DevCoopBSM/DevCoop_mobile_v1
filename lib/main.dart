import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aripay/login.dart';
import 'package:aripay/chargeUserLog.dart';
import 'package:aripay/useUserLog.dart';

void main() => runApp(
  MaterialApp(
    home: MyApp(initialLoggedInState: false),
  ),
);

class MyApp extends StatefulWidget {
  final bool initialLoggedInState;

  // initialLoggedInState를 필수 매개변수로 변경
  MyApp({required this.initialLoggedInState});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;


  @override
  void initState() {
    super.initState();
    isLoggedIn = widget.initialLoggedInState;
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
                isLoggedIn ?
                setState(() {
                  isLoggedIn = !isLoggedIn; // 로그인 상태를 변경
                }) : Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LoginApp()),
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
                    margin: isLoggedIn
                        ? EdgeInsets.only(left: 10, right: 130, top: 30)
                        : EdgeInsets.only(left: 10, right: 35, top: 30),
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
                          margin: EdgeInsets.only(top: 30, left: 20),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChargeUserLog()),
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
                        margin: EdgeInsets.only(top: 30, left: 135),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UseUserLog()),
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
