import 'package:flutter/material.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/widgets/Auth/change_language.dart';
import 'package:movieapp/widgets/common_widgets/customButton.dart';
import 'package:movieapp/widgets/common_widgets/cutomTextFormField.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = TextTheme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                ),
                SizedBox(height: 20),
                TextFormFieldCustom(
                  hintText: 'Password',
                  controller: passwordController,
                  prefixIconPath: 'assets/icons/password_icon.svg',
                  isPassword: true,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forget Password ?',
                        style: textTheme.bodyMedium
                            ?.copyWith(color: AppTheme.primary),
                      ),
                    ),
                  ],
                ),
                CustomButton(
                  buttonTitle: 'Login',
                  buttonColor: AppTheme.primary,
                  fontColor: AppTheme.gray,
                  onPressed: () {},
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don’t Have Account?',
                          style: textTheme.bodyMedium,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Create One',
                            style: textTheme.bodyMedium?.copyWith(
                              color: AppTheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
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
                  buttonColor: AppTheme.primary,
                  fontColor: AppTheme.gray,
                  iconPath: 'assets/icons/google_icon.svg',
                  onPressed: () {},
                ),
                SizedBox(height: 20),
                ChangeLanguage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
