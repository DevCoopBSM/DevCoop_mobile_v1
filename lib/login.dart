import 'package:flutter/material.dart';

void main() {
  runApp(Login());
}

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(120),
              ),
              Container(
                margin: EdgeInsets.all(5),
                child: Image.asset(
                  "assets/AriPayL.png",
                  fit: BoxFit.cover,
                  width: 100, // 가로 크기 지정
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
              ),
              const SizedBox(
                width: 300,
                child: TextField(
                  decoration: InputDecoration(
                    labelText: '이메일 입력해주세요',
                    hintText: '학교 이메일을 입력해주세요',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black12),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
              ),
              const SizedBox(
                width: 300,
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: '비밀번호를 입력해주세요',
                    hintText: 'Enter your Password',
                    labelStyle: TextStyle(color: Colors.black),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      borderSide: BorderSide(width: 1, color: Colors.black12),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
              ),
              ElevatedButton(
                onPressed: () {
                  // 로그인 버튼 클릭 시 동작 추가
                },
                child: Text("로그인"),
                style: ElevatedButton.styleFrom(

                  primary: Colors.yellow, // 버튼 배경색
                  onPrimary: Colors.black, // 버튼 텍스트 색상
                  minimumSize: Size(300, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 버튼의 모서리를 둥글게 설정
                  ),
                  elevation: 2, // 버튼의 그림자 깊이
                  shadowColor: Colors.grey, // 버튼의 그림자 색상
                  textStyle: TextStyle(
                    fontSize: 16, // 버튼 텍스트의 크기
                    fontWeight: FontWeight.bold, // 버튼 텍스트의 굵기
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
              ),
              Container(
                child: Text(
                  "학교이메일(@bssm.hs.kr)으로만 로그인이 가능합니다",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}