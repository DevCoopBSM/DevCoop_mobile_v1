import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<void> fetchData(
    String apiUrl, void Function(void Function()) setState) async {
  String _responseData = ''; // 데이터를 가져오기 전에 초기화
  try {
    final response = await http.get(Uri.parse(apiUrl)); // 클라이언트 이름을 요청에 포함
    print("response.body : ${response.body}");

    if (response.statusCode == 200) {
      final responseData = response.body;
      if (responseData.isNotEmpty) {
        setState(() {
          _responseData = responseData; // 정상적인 JSON 문자열로 설정
        });
      } else {
        setState(() {
          _responseData = '404 NOT FOUND';
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
  // fetchData 함수의 마지막에 반환문 추가
  return;
}
