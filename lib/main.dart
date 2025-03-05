import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_state.dart';
import 'package:movieapp/features/Profile/presntation/screens/profile_tab.dart';

import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferences.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/features/Auth/presentation/screens/forget_password_screen.dart';
import 'package:movieapp/features/Auth/presentation/screens/login_screen.dart';
import 'package:movieapp/features/Auth/presentation/screens/register_screen.dart';
import 'package:movieapp/features/onboarding/onboardingscreen/onboarding.dart';
import 'package:movieapp/features/Update_Profile/presentation/screens/update_profile.dart';

import 'features/Home_screen/presentation/screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorageServices.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit()..initializeAuth(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // final String? storedToken =
    //     LocalStorageServices.getString(LocalStorageKeys.authToken);

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darktheme,
        routes: {
          LoginScreen.routeName: (_) => LoginScreen(),
          UpdateProfile.routeName: (_) => UpdateProfile(),
          Signup.routeName: (_) => Signup(),
          ResetPasswordScreen.routeName: (_) => ResetPasswordScreen(),
          OnBoardingScreen.routeName: (_) => OnBoardingScreen(),
          HomeScreen.routeName: (_) => HomeScreen(),
          ProfileTab.routeName: (_) => ProfileTab(),
        },
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is AuthInitial || state is AuthLoading) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
            if (state is AuthLoginSuccess) {
              return HomeScreen();
            }
            bool runFirstTime = LocalStorageServices.getbool(
                  LocalStorageKeys.runforthefirsttime,
                ) ??
                false;
            return runFirstTime ? LoginScreen() : OnBoardingScreen();
          },
        ),
      ),
    );
  }
}
