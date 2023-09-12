import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:aripay/login.dart';

void main() => runApp(
  MaterialApp(
    home: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // 외부 URL
  final String externalUrl = 'https://www.instagram.com/bsm_devcoop';

  // 클릭 이벤트 처리
  void _launchURL() async {
    if (await canLaunch(externalUrl)) {
      await launch(externalUrl);
    } else {
      throw 'Could not launch $externalUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(// AppBar를 사용하여 헤더 생성
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start, // 이미지를 왼쪽으로 정렬
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
                // 여기에 로그인 페이지로 이동하는 코드를 추가하세요.
                // 예를 들어, Navigator를 사용하여 새로운 화면으로 이동할 수 있습니다.
                Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                "로그인",
                style: TextStyle(
                  color: Colors.black, // 텍스트 색상을 원하는 대로 변경하세요.
                ),
              ),
            ),
          ],
        ),
        body: Column(
          children: <Widget> [
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, top: 20), // 좌우 마진 30, 상단과 하단 마진은 여전히 30
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), // 하단 왼쪽 모서리 둥글게
                  topRight: Radius.circular(20), // 하단 오른쪽 모서리 둥글게
                ),
                color: Color.fromRGBO(65, 67, 76, 1.0),
              ),
              width: 400,
              height: 180,
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30), // 좌우, 하단 마진만 설정
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20), // 하단 왼쪽 모서리 둥글게
                  bottomRight: Radius.circular(20), // 하단 오른쪽 모서리 둥글게
                ),
                color: Color.fromRGBO(52, 52, 60, 1.0),
              ),
              width: 400,
              height: 100,
            ),
            Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30), // 좌우, 하단 마진만 설정
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20), // 하단 왼쪽 모서리 둥글게
                  bottomRight: Radius.circular(20), // 하단 오른쪽 모서리 둥글게
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.lightBlue,
              ),
              width: 400,
              height: 150,
            ),
            GestureDetector(
              onTap: _launchURL,
              child: Container(
                margin: EdgeInsets.only(left: 30, right: 30, bottom: 30), // 좌우, 하단 마진만 설정
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20), // 하단 왼쪽 모서리 둥글게
                    bottomRight: Radius.circular(20), // 하단 오른쪽 모서리 둥글게
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  color: Color.fromRGBO(240, 206, 0, 1.0),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0), // 왼쪽 마진 설정
                  child: Text(
                    "How\nTo\nUse",
                    style: TextStyle(
                      fontSize: 40.0, // 폰트 크기 설정
                      color: Colors.white, // 폰트 색상 설정
                      fontWeight: FontWeight.bold, // 폰트 굵기 설정
                      fontStyle: FontStyle.italic, // 폰트 스타일 설정
                      letterSpacing: 2.0, // 글자 간격 설정 (픽셀 단위)
                      wordSpacing: 5.0, // 단어 간격 설정
                      decorationColor: Colors.red, // 밑줄 색상 설정
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




