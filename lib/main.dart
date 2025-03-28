import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movieapp/core/LocalizationCubit.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_state.dart';
import 'package:movieapp/features/Profile/presentation/screens/profile_tab.dart';
import 'package:movieapp/features/Search/data/datasources/searchmoviedatasource.dart';
import 'package:movieapp/features/Search/data/repository/searchmovierepo.dart';
import 'package:movieapp/features/Search/presentation/cubit/searchmoviecubit.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferencekeys.dart';
import 'package:movieapp/features/onboarding/services/sharedpreferences.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/features/Auth/presentation/screens/forget_password_screen.dart';
import 'package:movieapp/features/Auth/presentation/screens/login_screen.dart';
import 'package:movieapp/features/Auth/presentation/screens/register_screen.dart';
import 'package:movieapp/features/onboarding/onboardingscreen/onboarding.dart';
import 'package:movieapp/features/Update_Profile/presentation/screens/update_profile.dart';
import 'features/Home_screen/presentation/screens/home_screen.dart';
import 'firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.enableNetwork();
  await LocalStorageServices.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit()..initializeAuth(),
        ),
        BlocProvider<LocalizationCubit>(
          create: (context) => LocalizationCubit(),
        ),
        BlocProvider(
          create: (context) => SearchMovieCubit(
            searchmovieRepository: SearchMovieRepository(
              dataSource: SearchMovieDataSource(),
            ),
          ),
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
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => BlocBuilder<LocalizationCubit, Locale>(
        builder: (context, locale) {
          return MaterialApp(
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
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: locale,
            home: BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                if (state is AuthInitial || state is AuthLoading) {
                  return const Scaffold(
                    body: Center(
                        child: CircularProgressIndicator(
                      color: Color(0xffF6BD00),
                    )),
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
          );
        },
      ),
    );
  }
}
