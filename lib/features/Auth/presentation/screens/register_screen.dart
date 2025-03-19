import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieapp/core/utils/validator.dart';
import 'package:movieapp/core/widgets/LoadingIndicatore.dart';
import 'package:movieapp/features/Auth/data/models/register_request.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_state.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/features/Auth/presentation/screens/login_screen.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/core/widgets/toggleSwitcher.dart';
import '../../../../core/widgets/cutomTextFormField.dart';
import '../../../Update_Profile/data/models/avatar_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Signup extends StatefulWidget {
  static const String routeName = "signup";

  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  AppLocalizations? Localizations;
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  Avatar? _selectedAvatar;
  Future<void> _submitForm() async {
    print(Avatar.avatarPaths.indexOf(_selectedAvatar!));
    if (_formKey.currentState!.validate()) {
      await context.read<AuthCubit>().register(RegisterRequest(
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
            phone: '+2${_phoneController.text}',
            avaterId: Avatar.avatarPaths.indexOf(_selectedAvatar!),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('${Localizations!.registrationFailed}: $e'),
            backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Localizations = AppLocalizations.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.black,
          title: Text('${Localizations?.register}'),
          foregroundColor: AppTheme.primary,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: CarouselSlider.builder(
                    options: CarouselOptions(
                      height: 150,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.3,
                      enableInfiniteScroll: true,
                      viewportFraction: 0.4,
                    ),
                    carouselController: _carouselController,
                    itemCount: Avatar.avatarPaths.length,
                    itemBuilder: (context, index, realIndex) {
                      bool isSelected =
                          _selectedAvatar == Avatar.avatarPaths[index];
                      _selectedAvatar ?? Avatar.avatarPaths.first;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedAvatar = Avatar.avatarPaths[index];
                          });
                          _carouselController.animateToPage(index);
                        },
                        child: Container(
                          width: isSelected ? 400 : 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: isSelected
                                ? Border.all(color: Colors.amber, width: 3)
                                : null,
                            boxShadow: isSelected
                                ? [
                                    BoxShadow(
                                      color: Colors.amber.withOpacity(0.5),
                                      blurRadius: 10,
                                    )
                                  ]
                                : [],
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                Avatar.avatarPaths[index].imagePath,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  Localizations!.avatar,
                  style: TextStyle(color: AppTheme.white, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormFieldCustom(
                    controller: _nameController,
                    hintText: Localizations!.name,
                    prefixIconPath: "assets/svg/name.svg",
                    validator: (value) =>
                        Validator.validateField(value, 'name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16),
                  child: TextFormFieldCustom(
                    controller: _emailController,
                    hintText: Localizations!.email,
                    prefixIconPath: "assets/svg/email.svg",
                    validator: (value) =>
                        Validator.validateField(value, 'email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormFieldCustom(
                    controller: _passwordController,
                    isPassword: true,
                    hintText: Localizations!.password,
                    prefixIconPath: "assets/svg/password.svg",
                    validator: (value) =>
                        Validator.validateField(value, 'password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16),
                  child: TextFormFieldCustom(
                    controller: _confirmPasswordController,
                    isPassword: true,
                    hintText: Localizations!.confirmPassword,
                    prefixIconPath: "assets/svg/password.svg",
                    validator: (value) => Validator.validateField(
                        value, 'confirmPassword',
                        password: _passwordController.text),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormFieldCustom(
                    controller: _phoneController,
                    hintText: Localizations!.phoneNumber,
                    prefixIconPath: "assets/svg/call.svg",
                    validator: (value) =>
                        Validator.validateField(value, 'phone'),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: BlocListener<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLoading) {
                        LoadingIndicator.show(context);
                      } else if (state is AuthSuccess) {
                        LoadingIndicator.hide(context);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          LoginScreen.routeName,
                          (Route<dynamic> route) => false,
                        );
                      } else if (state is AuthError) {
                        LoadingIndicator.hide(context);
                        Fluttertoast.showToast(msg: state.message);
                      }
                    },
                    child: CustomButton(
                      onPressed: _submitForm,
                      buttonTitle: Localizations!.createAccount,
                      buttonColor: AppTheme.primary,
                      fontColor: AppTheme.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: RichText(
                    text: TextSpan(
                      text: Localizations!.alreadyHaveAccount,
                      style: TextStyle(
                        fontSize: 17,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: Localizations!.login,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                            decorationThickness: 2,
                            height: 2.0,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .pushReplacementNamed(LoginScreen.routeName);
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                ToggleSwitcher(),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
