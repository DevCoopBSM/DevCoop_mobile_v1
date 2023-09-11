import 'package:flutter/material.dart';

void main() => runApp(
  MaterialApp(
    home: MyApp(),
  ),
);


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Container(
          color: Colors.yellow,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 400,
                height: 160,
                margin: EdgeInsets.only(top: 20),
                child: Image.asset(
                    "AriPayL_ver2.png",
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.all(30),
              ),
              const Text(
                  "부산소프트웨어마이스터고등학교 매점사이트 아리페이",
                  style: TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.none,
                      fontSize: 20
                  )
              ),
              Container(
                margin: const EdgeInsets.all(10),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, // 버튼 배경색
                  onPrimary: Colors.black, // 버튼 텍스트 색상
                  minimumSize: Size(350, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // 버튼의 모서리를 둥글게 설정
                  ),
                  elevation: 2, // 버튼의 그림자 깊이
                  shadowColor: Colors.grey, // 버튼의 그림자 색상
                  textStyle: const TextStyle(
                    fontSize: 16, // 버튼 텍스트의 크기
                    fontWeight: FontWeight.bold, // 버튼 텍스트의 굵기
                  ),
                ),
                onPressed: () {  },
                child: Text("로그인하기"),
              ),
            ],
          ),
        )
    );
  }
}
