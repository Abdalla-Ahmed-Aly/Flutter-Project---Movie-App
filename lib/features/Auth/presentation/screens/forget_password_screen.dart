import 'package:flutter/material.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import '../../../../theme/apptheme.dart';
import '../../../../core/widgets/cutomTextFormField.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routeName = "forgetPassword";

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>(); // Form Key
  final TextEditingController _emailController =
      TextEditingController(); // Email Controller

  // Email Validator
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

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
      // Email is valid
      print('Email is valid: ${_emailController.text}');
      _showSnackbar('Verification email sent successfully!', Colors.green);
    } else {
      // Invalid email
      _showSnackbar('Please fix the errors before proceeding.', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.black,
        title: const Text(
          'Forget Password',
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
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIconPath: "assets/svg/email.svg",
                  validator: _validateEmail,
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
      ),
    );
  }
}