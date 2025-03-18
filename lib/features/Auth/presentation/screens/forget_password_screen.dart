import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/features/Auth/data/models/reset_password_request.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_state.dart';
import 'package:movieapp/features/Home_screen/presentation/screens/home_screen.dart';
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
  final _formKey = GlobalKey<FormState>();
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
      final oldPassword = _oldPasswordController.text.trim();
      final newPassword = _newPasswordController.text.trim();

      if (oldPassword.isEmpty || newPassword.isEmpty) {
        _showSnackbar('Please fill in all fields.', Colors.red);
        return;
      }

      context.read<AuthCubit>().resetPssword(ResetPasswordRequest(
            oldPassword: oldPassword,
            newPassword: newPassword,
          ));
    } else {
      _showSnackbar('Please fix the errors before proceeding.', Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Center(child: CircularProgressIndicator(color: AppTheme.primary,)),
          );
        } else if (state is ResetPasswordSuccess) {
          Navigator.of(context)
              .pushReplacementNamed(HomeScreen.routeName, arguments: 3);
          _showSnackbar(
              state.resetPasswordResponse.message ??
                  'Password reset successfully!',
              Colors.green);
        } else if (state is AuthError) {
          Navigator.pop(context);
          _showSnackbar(state.message, Colors.red);
        }
      },
      child: Scaffold(
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
                    hintText: 'Old Password',
                    prefixIconPath: "assets/svg/password.svg",
                    validator: (value) =>
                        Validator.validateField(value, 'Old Password'),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 16.0, right: 16, left: 16),
                  child: TextFormFieldCustom(
                    controller: _newPasswordController,
                    hintText: 'New Password',
                    prefixIconPath: "assets/svg/password.svg",
                    validator: (value) =>
                        Validator.validateField(value, 'New Password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: CustomButton(
                    onPressed: _submitForm,
                    buttonTitle: 'Reset',
                    buttonColor: AppTheme.primary,
                    fontColor: AppTheme.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
