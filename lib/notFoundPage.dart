import 'package:flutter/material.dart';

void main() {
  runApp(NotFound());
}

class NotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(140),
              ),
              Container(
                child: Image.asset(
                  "assets/404.png"
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
              ),
              Container(
                child: Text(
                  "죄송합니다. 페이지를 찾을 수 없습니다 :(",
                  style: TextStyle(
                    color: Color.fromARGB(255, 245, 212, 16),
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ),
              Container(
                child: Text(
                  "존재하지 않는 주소를 입력하셨거나\n요청하신 페이지의 주소 변경, 삭제되어 찾을 수 없습니다.",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
              ),
              ElevatedButton(
                onPressed: () {
                  // 로그인 버튼 클릭 시 동작 추가

                },
                child: Text("홈으로"),
                style: ElevatedButton.styleFrom(

                  primary: Colors.yellow, // 버튼 배경색
                  onPrimary: Colors.black, // 버튼 텍스트 색상
                  minimumSize: Size(150, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // 버튼의 모서리를 둥글게 설정
                  ),
                  elevation: 2, // 버튼의 그림자 깊이
                  shadowColor: Colors.grey, // 버튼의 그림자 색상
                  textStyle: TextStyle(
                    fontSize: 16, // 버튼 텍스트의 크기
                    fontWeight: FontWeight.bold, // 버튼 텍스트의 굵기
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}