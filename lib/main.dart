import 'package:flutter/material.dart';
import 'package:movieapp/widgets/Auth/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routName: (_) => LoginScreen(),
      },
      initialRoute: LoginScreen.routName,
    );
  }
}
