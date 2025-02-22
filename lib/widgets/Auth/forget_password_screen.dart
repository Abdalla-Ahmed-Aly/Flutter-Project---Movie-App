import 'package:flutter/material.dart';
import 'package:movieapp/widgets/common_widgets/customButton.dart';

import '../common_widgets/cutomTextFormField.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = "forgetPassword";

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Forget Password',
          style: TextStyle(fontSize: 16),
        ),
        foregroundColor: Colors.amber,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/Forgot password-bro 1.png"),
            TextFormFieldCustom(
              hintText: 'Email',
               prefixIconPath: "assets/svg/email.svg",
            ),
            CustomButton(
              onPressed: (){

              },
              buttonTitle: 'Verify Email',
              buttonColor: Colors.amber,
              fontColor: Colors.black,

            ),
          ],
        ),
      ),
    );
  }
}
