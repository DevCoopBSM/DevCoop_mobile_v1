import 'package:aripay/main.dart';
import 'package:aripay/ui/screen/auth/login.dart';
import 'package:get/route_manager.dart';

List<GetPage> appRouter = [
  GetPage(name: '/', page: () => const MyApp()),
  GetPage(name: '/login', page: () => const LoginPage()),
];
