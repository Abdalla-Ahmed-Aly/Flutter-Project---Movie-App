import 'package:flutter/material.dart';
import 'package:movieapp/widgets/Auth/forget_password_screen.dart';
import 'package:movieapp/widgets/Auth/login_screen.dart';
import 'package:movieapp/widgets/Auth/register_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        Signup.routeName: (_) => Signup(),
        ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
       },
      initialRoute: ForgetPasswordScreen.routeName,
    );
  }
}
