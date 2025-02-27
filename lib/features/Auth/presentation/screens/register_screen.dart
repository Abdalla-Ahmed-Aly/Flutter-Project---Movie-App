import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:movieapp/core/utils/validator.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/features/Auth/presentation/screens/login_screen.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/core/widgets/toggleSwitcher.dart';
import 'package:movieapp/features/Update_Profile/presentation/screens/update_profile.dart';
import '../../../../core/widgets/cutomTextFormField.dart';
import '../../../Update_Profile/data/models/avatar_model.dart';

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
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  Avatar? _selectedAvatar;

 



  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Registration successful'),
            backgroundColor: Colors.green),
      );
      Navigator.of(context).pushNamed(UpdateProfile.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Form data is invalid'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.black,
          title: const Text('Register'),
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
                      bool isSelected = _selectedAvatar == Avatar.avatarPaths[index];
                      if (_selectedAvatar == null) {
                        _selectedAvatar = Avatar.avatarPaths.first;
                      }
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
                  "Avatar",
                  style: TextStyle(color: AppTheme.white, fontSize: 20),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormFieldCustom(
                    controller: _nameController,
                    hintText: 'Name',
                    prefixIconPath: "assets/svg/name.svg",
                    validator: (value) => Validator.validateField(value, 'name'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16),
                  child: TextFormFieldCustom(
                    controller: _emailController,
                    hintText: 'Email',
                    prefixIconPath: "assets/svg/email.svg",
                    validator: (value) => Validator.validateField(value, 'email'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormFieldCustom(
                    controller: _passwordController,
                    isPassword: true,
                    hintText: 'Password',
                    prefixIconPath: "assets/svg/password.svg",
                    validator: (value) => Validator.validateField(value, 'password'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 16),
                  child: TextFormFieldCustom(
                    controller: _confirmPasswordController,
                    isPassword: true,
                    hintText: "Confirm Password",
                    prefixIconPath: "assets/svg/password.svg",
                    validator: (value) =>
                        Validator.validateField(value, 'confirmPassword',password: _passwordController.text),
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextFormFieldCustom(
                    controller: _phoneController,
                    hintText: 'Phone Number',
                    prefixIconPath: "assets/svg/call.svg",
                    validator: (value) => Validator.validateField(value, 'phone'),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                  child: CustomButton(
                    onPressed: _submitForm,
                    buttonTitle: 'Create Account',
                    buttonColor: AppTheme.primary,
                    fontColor: AppTheme.black,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: RichText(
                    text: TextSpan(
                      text: 'Already Have Account? ',
                      style: TextStyle(
                        fontSize: 17,
                        letterSpacing: 0.7,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primary,
                            decorationThickness: 2,
                            height: 2.0,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
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