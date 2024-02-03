import 'package:aripay/ui/screen/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;
  int? userPoint;

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
              onPressed: () {},
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
              margin: const EdgeInsets.only(left: 30, right: 30, top: 20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Color.fromRGBO(65, 67, 76, 1.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              width: 400,
              height: 180,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 155, top: 40),
                    child: const Text(
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
                        ? const EdgeInsets.only(left: 30, right: 220, top: 30)
                        : const EdgeInsets.only(left: 10, right: 85, top: 30),
                    width: 200,
                    child: Text(
                      isLoggedIn ? "${userPoint ?? null}원" : "로그인을 해주세요",
                      style: const TextStyle(
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
              margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          margin: EdgeInsets.only(top: 30, left: 20),
                          child: TextButton(
                            onPressed: () {
                              Get.toNamed("/chargeLog");
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
                            Get.toNamed("/useLog");
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
              onTap: () {
                null;
              },
              child: Container(
                margin: const EdgeInsets.only(left: 30, right: 30, bottom: 30),
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
                  borderRadius: const BorderRadius.only(
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
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                width: 400,
                height: 150,
              ),
            ),
            GestureDetector(
              onTap: null,
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
                      offset: const Offset(2, 4),
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
