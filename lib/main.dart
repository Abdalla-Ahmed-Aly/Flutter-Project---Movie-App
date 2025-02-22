import 'package:flutter/material.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/widgets/Auth/login_screen.dart';
import 'package:movieapp/widgets/Auth/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darktheme,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
       },
      initialRoute: LoginScreen.routeName,
    );
  }
}
