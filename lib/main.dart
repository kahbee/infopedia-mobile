import 'package:flutter/material.dart';
import 'package:infopediaflutter/api/sp.dart';
import 'package:infopediaflutter/pages/home_view.dart';
import 'package:infopediaflutter/pages/login_view.dart';
import 'package:infopediaflutter/pages/register_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var initialRoute = '/home';
  var token = await getToken();
  if (token != "") {
    initialRoute = '/home';
  }
  runApp(MainApp(initialRoute: initialRoute));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
