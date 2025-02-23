import 'package:flutter/material.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/widgets/Auth/login_screen.dart';
import 'package:movieapp/widgets/Home_Screen/HomeScreen.dart';
import 'package:movieapp/widgets/update_profile/update_profile.dart';

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
        Homescreen.routeName: (_) => Homescreen(),
        UpdateProfile.routeName: (_) => UpdateProfile(),
       },
      initialRoute: LoginScreen.routeName,
    );
  }
}
