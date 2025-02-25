import 'package:flutter/material.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferences.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/features/Auth/presentation/screens/forget_password_screen.dart';
import 'package:movieapp/features/Auth/presentation/screens/login_screen.dart';
import 'package:movieapp/features/Auth/presentation/screens/register_screen.dart';
import 'package:movieapp/features/onboarding/onboardingscreen/onboarding.dart';
import 'package:movieapp/features/Update_Profile/presentation/screens/update_profile.dart';

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
          UpdateProfile.routeName: (_) => UpdateProfile(),
          Signup.routeName: (_) => Signup(),
          ForgetPasswordScreen.routeName: (_) => ForgetPasswordScreen(),
          OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
        },
        initialRoute: runforthefirsttime
            ? LoginScreen.routeName
            : OnBoardingScreen.routeName);
  }
}
