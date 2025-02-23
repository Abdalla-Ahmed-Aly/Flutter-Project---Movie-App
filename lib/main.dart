import 'package:flutter/material.dart';
import 'package:movieapp/services/sharedpreferencekeys.dart';
import 'package:movieapp/services/sharedpreferences.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/widgets/Auth/login_screen.dart';
import 'package:movieapp/widgets/Home_Screen/HomeScreen.dart';
import 'package:movieapp/widgets/onboardingscreen/onboarding.dart';
import 'package:movieapp/widgets/update_profile/update_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageServices.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    bool runforthefirsttime = LocalStorageServices.getbool(
          LocalStorageKeys.runforthefirsttime,
        ) ??
        false;
    bool loginpagekey = LocalStorageServices.getbool(
          LocalStorageKeys.loginpagekey,
        ) ??
        false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darktheme,
      routes: {
        LoginScreen.routeName: (_) => LoginScreen(),
        HomeScreen.routeName: (_) => HomeScreen(),
        UpdateProfile.routeName: (_) => UpdateProfile(),
        OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
      },
      initialRoute: runforthefirsttime
          ? loginpagekey
              ? HomeScreen.routeName
              : LoginScreen.routeName
          : OnBoardingScreen.routeName,
    );
  }
}
