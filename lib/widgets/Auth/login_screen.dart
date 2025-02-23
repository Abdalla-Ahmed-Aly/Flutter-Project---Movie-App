import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/widgets/Auth/change_language.dart';
import 'package:movieapp/widgets/Home_Screen/HomeScreen.dart';
import 'package:movieapp/widgets/common_widgets/customButton.dart';
import 'package:movieapp/widgets/common_widgets/cutomTextFormField.dart';
import 'package:movieapp/widgets/common_widgets/toggleSwitcher.dart';

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

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Scaffold(
      body: SafeArea(
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
                    hintText: 'Email',
                    controller: emailController,
                    prefixIconPath: 'assets/icons/email_icon.svg',
                    validator: (value) {
                      if (value == null || value.length < 5) {
                        return 'Invalid Email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormFieldCustom(
                    hintText: 'Password',
                    controller: passwordController,
                    prefixIconPath: 'assets/icons/password_icon.svg',
                    isPassword: true,
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return 'Password can not be Less than 8 characters ';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forget Password ?',
                          style: textTheme.bodyLarge
                              ?.copyWith(color: AppTheme.primary),
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                    buttonTitle: 'Login',
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
                              text: 'Don\'t Have Account ? ',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            TextSpan(
                              text: 'Create Account',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: AppTheme.primary,
                                  ),
                              recognizer: TapGestureRecognizer()..onTap = () {},
                            ),
                          ],
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       'Don’t Have Account?',
                      //       style: textTheme.bodyLarge,
                      //     ),
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: Text(
                      //         'Create One',
                      //         style: textTheme.bodyMedium?.copyWith(
                      //           color: AppTheme.primary,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
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
                                style: TextStyle(
                                    color: AppTheme.primary, fontSize: 14),
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
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacementNamed(Homescreen.routeName);
    }
  }
}
