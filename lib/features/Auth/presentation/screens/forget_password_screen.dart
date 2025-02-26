import 'package:flutter/material.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import '../../../../core/utils/validator.dart';
import '../../../../theme/apptheme.dart';
import '../../../../core/widgets/cutomTextFormField.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String routeName = "forgetPassword";

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>(); // Form Key
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  void _showSnackbar(String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: bgColor,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Email is valid: ${_newPasswordController.text}');
      _showSnackbar('Verification email sent successfully!', Colors.green);
    } else {
      _showSnackbar('Please fix the errors before proceeding.', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.black,
          title: const Text(
            'Reset Password',
            style: TextStyle(fontSize: 16),
          ),
          foregroundColor: Colors.amber,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset("assets/images/Forgot password-bro 1.png"),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormFieldCustom(
                    controller: _oldPasswordController,
                    hintText: 'old password',
                    prefixIconPath: "assets/svg/password.svg",
                    validator: (value) =>
                        Validator.validateField(value, 'password'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, right: 16, left: 16),
                  child: TextFormFieldCustom(
                    controller: _newPasswordController,
                    hintText: 'new password',
                    prefixIconPath: "assets/svg/password.svg",
                    validator: (value) => Validator.validateField(
                      value,
                      'new password',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    onPressed: _submitForm,
                    buttonTitle: 'Verify Email',
                    buttonColor: AppTheme.primary,
                    fontColor: AppTheme.black,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
