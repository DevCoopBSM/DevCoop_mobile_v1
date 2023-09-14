import 'package:flutter/material.dart';
import 'package:aripay/login.dart';

void main() => runApp(
  MaterialApp(
    home: ChargeUserLog(),
  ),
);

class ChargeUserLog extends StatefulWidget {
  @override
  _ChargeUserLogState createState() => _ChargeUserLogState();
}

class _ChargeUserLogState extends State<ChargeUserLog> {
  bool isLoggedIn = false;

  // 로그아웃 처리 함수
  void _handleLogout() {
    // 여기에서 로그아웃 로직을 구현하세요.
    // 사용자 로그아웃 상태로 변경
    setState(() {
      !isLoggedIn;
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
        body: ListView( // ListView로 변경
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 텍스트를 좌우로 배치
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
                  margin: EdgeInsets.only(top: 30, right: 15),
                  child: Text(
                    "9000" + "원",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
            ),
            Divider(
              color: Colors.black12,  // 줄의 색상 설정
              thickness: 2.0, // 줄의 두께 설정
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 텍스트를 좌우로 배치
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    "사용내역",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  child: Image.asset(
                    "assets/filter.png",
                    height: 20,
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
            ),
            ContainerList(),
          ],
        ),
      ),
    );
  }
}

class ContainerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Container 위젯들을 저장할 리스트
    List<Container> containers = [];

    // 10개의 파란색 Container를 생성하여 리스트에 추가
    for (int i = 0; i < 10; i++) {
      containers.add(
        Container(
          width: 900,
          height: 70, // 높이를 조정
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text('Container $i', style: TextStyle(color: Colors.black)),
          decoration: BoxDecoration(
            color: Color.fromRGBO(230, 235, 255, 1.0),
            borderRadius: BorderRadius.circular(10), // BorderRadius 수정
          ),
        ),
      );
    }

    // 리스트의 모든 Container를 Column에 출력
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: containers,
    );
  }
}
