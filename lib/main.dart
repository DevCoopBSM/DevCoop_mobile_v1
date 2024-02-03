import 'package:aripay/utils/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AriPay',
      debugShowCheckedModeBanner: false,
      getPages: appRouter,
      initialRoute: '/',
    );
  }
}
