import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aripay/main.dart';
import 'package:aripay/login.dart';

final String userPointKey = 'userPoint';
final String accessTokenKey = 'accToken';
final String refreshTokenKey = 'refToken';

void main() {
  bool isLoggedIn = true;
  runApp(UseUserLog(
    isLoggedIn: isLoggedIn,
    updateLoginStatus: (bool status) {
      isLoggedIn = status;
    },
  ));
}

class UseUserLog extends StatefulWidget {
  final bool isLoggedIn;
  final Function(bool) updateLoginStatus;

  UseUserLog({required this.isLoggedIn, required this.updateLoginStatus});

  @override
  _UseUserLogState createState() => _UseUserLogState();
}

class _UseUserLogState extends State<UseUserLog> {
  String _responseData = ''; // 서버 응답 데이터를 저장할 변수
  final apiUrl = 'http://10.129.57.5/api/payuserlog';
  int? userPoint;

  @override
  void initState() {
    super.initState();
    fetchData();
    loadSavedData();
  }

  Future<int?> loadUserPoint() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userPoint = prefs.getInt(userPointKey);
    return userPoint ?? 0; // 기본값으로 0을 반환하도록 수정
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userPoint = await loadUserPoint();
    setState(() {
      this.userPoint = userPoint;
    });
    print('사용자 포인트: $userPoint');
  }

  Future<String?> getClientName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? p = prefs.getString('clientName');
    print("사용자 이름 : $p");
    return p ?? ""; // 기본값으로 빈 문자열 반환
  }

  Future<void> fetchData() async {
    print("check");
    String? clientName = await getClientName();
    try {
      final response = await http.get(Uri.parse('$apiUrl?clientname=$clientName')); // 클라이언트 이름을 요청에 포함
      print("response.body : ${response.body}");

      if (response.statusCode == 200) {
        final responseData = response.body;
        if (responseData.isNotEmpty) {
          setState(() {
            _responseData = responseData; // 정상적인 JSON 문자열로 설정
          });
        } else {
          setState(() {
            _responseData = '서버 응답이 비어있습니다.';
          });
        }
      } else {
        setState(() {
          _responseData = '서버 응답이 실패했습니다: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _responseData = '데이터를 가져올 수 없습니다: $e';
      });
    }
  }

  Future<void> _logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(accessTokenKey);
    print("accToken 제거됨");

    widget.updateLoginStatus(false);

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
                widget.isLoggedIn
                    ? _logout(context)
                    : Navigator.push(
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
        body: SingleChildScrollView(
          child: Column(
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
                        color: Colors.black45,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30, right: 15),
                    child: Text(
                      "${widget.isLoggedIn ? userPoint ?? "" : ""} 원",
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
                        color: Colors.black,
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
              ContainerList(responseData: _responseData),
            ],
          ),
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
    final List<dynamic> data = json.decode(responseData);

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: data.length, // 데이터의 개수로 itemCount를 설정
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
          child: Text('$date        $innerPoint원       결제'),
          decoration: BoxDecoration(
            color: Color(0xFFE7E7E7),
            borderRadius: BorderRadius.circular(10),
          ),
        );
      },
    );
  }
}
