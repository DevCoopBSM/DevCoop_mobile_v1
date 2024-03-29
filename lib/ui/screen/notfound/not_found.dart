import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotFound extends StatelessWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(140),
          ),
          Image.asset("assets/404.png"),
          Container(
            margin: const EdgeInsets.all(20),
          ),
          const Text(
            "죄송합니다. 페이지를 찾을 수 없습니다 :(",
            style: TextStyle(
              color: Color.fromARGB(255, 245, 212, 16),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "존재하지 않는 주소를 입력하셨거나\n요청하신 페이지의 주소 변경, 삭제되어 찾을 수 없습니다.",
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
            ),
          ),
          Container(
            margin: const EdgeInsets.all(20),
          ),
          ElevatedButton(
            onPressed: () {
              // 여기에 로그인 페이지로 이동하는 코드를 추가하세요.
              // 예를 들어, Navigator를 사용하여 새로운 화면으로 이동할 수 있습니다.
              Get.toNamed("/");
            },
            style: ElevatedButton.styleFrom(
              // primary: Color.fromRGBO(252, 200, 0, 1.0), // 버튼 배경색
              minimumSize: const Size(150, 50), // 버튼 최소 크기
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // 버튼의 모서리를 둥글게 설정
              ),
              elevation: 2, // 버튼의 그림자 깊이
              shadowColor: Colors.grey, // 버튼의 그림자 색상
              textStyle: const TextStyle(
                fontSize: 16, // 버튼 텍스트의 크기
                fontWeight: FontWeight.bold, // 버튼 텍스트의 굵기
                color:
                    Color.fromRGBO(252, 200, 0, 1.0), // 텍스트 색상을 원하는 대로 변경하세요.
              ),
            ),
            child: const Text("홈으로"),
          ),
        ],
      ),
    );
  }
}
