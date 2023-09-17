import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aripay/login.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aripay/main.dart';

final String userPointKey = 'userPoint';
final String accessTokenKey = 'accToken';
final String refreshTokenKey = 'refToken';

void main() {
  bool isLoggedIn = true; // 여기에 로그인 상태를 나타내는 값을 할당합니다.
  runApp(UseUserLog(
    isLoggedIn: isLoggedIn,
    updateLoginStatus: (bool status) {
      isLoggedIn = status;
    },
  ));
}

class UseUserLog extends StatefulWidget {
  final bool isLoggedIn; // 부모에서 전달된 isLoggedIn 상태
  final Function(bool) updateLoginStatus; // 부모에서 전달된 상태 업데이트 함수

  UseUserLog({required this.isLoggedIn, required this.updateLoginStatus}); // 생성자를 통해 값 전달
  @override
  _UseUserLogState createState() => _UseUserLogState();
}

class _UseUserLogState extends State<UseUserLog> {
  String _responseData = ''; // 서버 응답 데이터를 저장할 변수
  // final apiUrl = 'http://10.10.0.11:6002/api/chargeuserlog'; // API 엔드포인트 URL
  final apiUrl = 'http://10.129.57.5:6002/api/useuserlog'; // API 엔드포인트 URL
  int? userPoint; // 사용자 포인트 정보를 저장할 변수

  @override
  void initState() {
    super.initState();
    // 앱이 시작될 때 데이터를 가져오도록 initState에서 fetchData 호출
    fetchData();
    loadSavedData(); // 사용자 포인트 데이터를 불러오도록 추가
  }

  // SharedPreferences에서 사용자 포인트를 불러오는 함수
  Future<int?> loadUserPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userPoint = prefs.getInt(userPointKey);
    return userPoint;
  }

  // 저장된 사용자 데이터를 불러와서 화면에 업데이트하는 함수
  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
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

  // 사용자 이름을 SharedPreferences에서 가져오는 함수
  Future<String?> getClientName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('clientName');
  }

  // 서버에서 데이터를 가져오는 함수
  Future<void> fetchData() async {
    String? studentName = await getClientName() ?? "";
    try {
      final response = await http.get(
        Uri.parse('$apiUrl?clientname=$studentName'),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print(response);

      if (response.statusCode == 200) {
        // 응답이 유효한 JSON인지 확인
        if (response.body.isNotEmpty) {
          final data = json.decode(response.body);
          setState(() {
            _responseData = json.encode(data);
          });
        } else {
          setState(() {
            _responseData = '서버로부터 데이터를 받지 못했습니다.';
          });
        }
      } else {
        setState(() {
          _responseData = 'API 요청 실패: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _responseData = '데이터를 가져올 수 없습니다: $e';
      });
    }
  }

  // 로그아웃 처리 함수
  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(accessTokenKey); // 수정: 'accToken' 대신 변수 사용
    print("accToken 제거됨");

    widget.updateLoginStatus(false); // 로그아웃 상태를 상위 위젯으로 전달

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(initialLoggedInState: false),
      ),
    );
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
                print(widget.isLoggedIn);
                widget.isLoggedIn ? _logout(context) :
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginApp()),
                );
              },
              child: Text(
                widget.isLoggedIn ? "로그아웃" : "로그인",
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
                    "${widget.isLoggedIn ? userPoint : ""} 원",
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
            ContainerList(
                responseData: _responseData
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerList extends StatelessWidget {
  final String responseData;

  ContainerList({
    required this.responseData,
  });

  @override
  Widget build(BuildContext context) {
    // responseData에서 데이터를 파싱하여 리스트에 추가
    final List<dynamic> data = json.decode(responseData);

    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final item = data[index];
        String date = item['date'];
        String innerPoint = item['inner_point'].toString();
        String type = item['type'].toString();

        return Container(
          width: 900,
          height: 70,
          margin: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text('$date $innerPoint $type'),
          decoration: BoxDecoration(
            color: Color.fromRGBO(230, 235, 255, 1.0),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }
}