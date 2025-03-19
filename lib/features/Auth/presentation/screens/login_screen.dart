import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/widgets/LoadingIndicatore.dart';
import 'package:movieapp/features/Auth/data/models/login_request.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_state.dart';
import 'package:movieapp/features/Home_screen/presentation/screens/home_screen.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/features/Auth/presentation/screens/register_screen.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/core/widgets/cutomTextFormField.dart';
import 'package:movieapp/core/widgets/toggleSwitcher.dart';
import '../../../../core/utils/validator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool language = false;
  String? token;

  @override
  Widget build(BuildContext context) {
    final Localizations = AppLocalizations.of(context);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              LoadingIndicator();
            } else if (state is AuthLoginSuccess) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
              token = state.token;
            } else if (state is AuthError) {
              Navigator.of(context).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 50),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/login_screen_header.png',
                      height: MediaQuery.of(context).size.height * 0.15,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(height: 70),
                    TextFormFieldCustom(
                      hintText: Localizations!.email,
                      controller: emailController,
                      prefixIconPath: 'assets/icons/email_icon.svg',
                      validator: (value) =>
                          Validator.validateField(value, 'email'),
                    ),
                    SizedBox(height: 20),
                    TextFormFieldCustom(
                      hintText: Localizations.password,
                      controller: passwordController,
                      prefixIconPath: 'assets/icons/password_icon.svg',
                      isPassword: true,
                      validator: (value) =>
                          Validator.validateField(value, 'password'),
                    ),
                    SizedBox(height: 30),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [
                    //     TextButton(
                    //       onPressed: () {
                    //         Navigator.of(context)
                    //             .pushNamed(ResetPasswordScreen.routeName);
                    //       },
                    //       child: Text(
                    //         'Forget Password ?',
                    //         style: textTheme.bodyLarge
                    //             ?.copyWith(color: AppTheme.primary),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    CustomButton(
                      buttonTitle: Localizations.login,
                      buttonColor: AppTheme.primary,
                      fontColor: AppTheme.gray,
                      onPressed: () {
                        login();
                      },
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: [
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodyLarge,
                            children: [
                              TextSpan(
                                text: Localizations.haveAccount,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              TextSpan(
                                text: Localizations.createOne,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: AppTheme.primary,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.of(context)
                                        .pushNamed(Signup.routeName);
                                  },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 60),
                          child: Row(
                            children: [
                              Flexible(
                                flex: 2,
                                child: Divider(
                                  color: AppTheme.primary,
                                  thickness: 1,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  'OR',
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: AppTheme.primary,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 2,
                                child: Divider(
                                  color: AppTheme.primary,
                                  thickness: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomButton(
                      buttonTitle: 'Login With Google',
                      buttonTitleStyle: textTheme.titleSmall?.copyWith(
                        color: AppTheme.gray,
                      ),
                      buttonColor: AppTheme.primary,
                      fontColor: AppTheme.gray,
                      iconPath: 'assets/icons/google_icon.svg',
                      onPressed: () {},
                    ),
                    SizedBox(height: 24),
                    ToggleSwitcher(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      context.read<AuthCubit>().login(
            LoginRequest(
              email: email,
              password: password,
            ),
          );
    }
  }
}
