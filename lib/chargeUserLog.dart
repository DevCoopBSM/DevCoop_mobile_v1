import 'package:flutter/material.dart';
import 'package:aripay/login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  String _responseData = '';
  final apiUrl = 'http://10.129.57.5:6002/api/chargeuserlog';

  @override
  void initState() {
    super.initState();
    // 앱이 시작될 때 데이터를 가져오도록 initState에서 fetchData 호출
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // API 요청이 성공하면 응답 데이터를 가져옵니다.
        final data = json.decode(response.body);
        setState(() {
          _responseData = json.encode(data); // JSON 데이터를 다시 문자열로 변환
        });
      } else {
        // API 요청이 실패한 경우 오류 메시지를 표시합니다.
        setState(() {
          _responseData = 'API 요청 실패: ${response.statusCode}';
        });
      }
    } catch (e) {
      // 네트워크 오류 등 예외 처리
      setState(() {
        _responseData = '데이터를 가져올 수 없습니다.';
      });
    }
  }

  // 로그아웃 처리 함수
  void _handleLogout() {
    // 여기에서 로그아웃 로직을 구현하세요.
    // 사용자 로그아웃 상태로 변경
    setState(() {
      isLoggedIn = false; // 상태를 변경하도록 수정
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
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => LoginApp()));
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
        body: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30, left: 15),
                  child: Text(
                    "남은 금액",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.black45),
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
              color: Colors.black12,
              thickness: 2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: Text(
                    "사용내역",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black),
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
            ContainerList(responseData: _responseData),
          ],
        ),
      ),
    );
  }
}

class ContainerList extends StatelessWidget {
  final String responseData;

  ContainerList({required this.responseData});

  @override
  Widget build(BuildContext context) {
    // Container 위젯들을 저장할 리스트
    List<Container> containers = [];

    try {
      // responseData에서 데이터를 파싱하여 리스트에 추가
      final List<dynamic> data = json.decode(responseData);
      for (var item in data) {
        String date = item['date'];
        String innerPoint = item['innerPoint'].toString();
        String type = item['type'].toString();

        containers.add(
          Container(
            width: 900,
            height: 70,
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text('$date $innerPoint $type'),
            decoration: BoxDecoration(
              color: Color.fromRGBO(230, 235, 255, 1.0),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }
    } catch (e) {
      // 데이터 파싱 오류 처리
      containers.add(
        Container(
          width: 900,
          height: 70,
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text('데이터를 불러올 수 없습니다.'),
          decoration: BoxDecoration(
            color: Color.fromRGBO(230, 235, 255, 1.0),
            borderRadius: BorderRadius.circular(10),
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