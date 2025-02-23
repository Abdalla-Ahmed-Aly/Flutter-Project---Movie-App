import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/gestures.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/widgets/common_widgets/customButton.dart';
import 'package:movieapp/widgets/update_profile/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_widgets/cutomTextFormField.dart';
import 'change_language.dart';

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
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  int _selectedAvatar = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadAvatar();
    WidgetsBinding.instance.addPostFrameCallback((_) => _centerInitialAvatar());
  }

  void _loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedAvatar = prefs.getInt('selectedAvatar') ?? 0;
    });
  }

  void _saveAvatar(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedAvatar', index);
  }

  void _centerInitialAvatar() {
    final double initialOffset = (_selectedAvatar * 100).toDouble();
    _scrollController.animateTo(
      initialOffset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  String? _validateField(String? value, String fieldType) {
    switch (fieldType) {
      case 'name':
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your name';
        } else if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
          return 'Name should contain only letters';
        }
        break;
      case 'email':
        if (value == null || value.trim().isEmpty) {
          return 'Please enter your email';
        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
          return 'Enter a valid email';
        }
        break;
      case 'password':
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        } else if (value.length < 8) {
          return 'Password must be at least 8 characters';
        } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d).+$').hasMatch(value)) {
          return 'Password must contain an uppercase letter and a number';
        }
        break;
      case 'confirmPassword':
        if (value != _passwordController.text) {
          return 'Passwords do not match';
        }
        break;
      case 'phone':
        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        } else if (!RegExp(r'^01\d{9}$').hasMatch(value)) {
          return 'Enter a valid 11-digit phone number';
        }
        break;
    }
    return null;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Reiteration is done successfully'), backgroundColor: Colors.green),
      );
      Navigator.of(context).pushNamed(UpdateProfile.routeName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form data is invalid'), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> avatarPaths = [
      'assets/Avatar/gamer1.png',
      'assets/Avatar/gamer2.png',
      'assets/Avatar/gamer3.png',
      'assets/Avatar/gamer4.png',
      'assets/Avatar/gamer5.png',
      'assets/Avatar/gamer6.png',
      'assets/Avatar/gamer7.png',
      'assets/Avatar/gamer8.png',
      'assets/Avatar/gamer9.png',
    ];

    return Scaffold(
       appBar: AppBar(
        backgroundColor:AppTheme.black,
        title: const Text('Register'),
        foregroundColor: AppTheme.primary,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: avatarPaths.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedAvatar = index;
                        });
                        _saveAvatar(index);
                        _centerInitialAvatar();
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                         decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: _selectedAvatar == index
                              ? Border.all(color: Colors.amber, width: 3)
                              : null,
                        ),
                        child: CircleAvatar(
                          radius: _selectedAvatar == index ? 90 : 30,
                          backgroundColor: AppTheme.black,
                          child: Image.asset(
                            avatarPaths[index],
                            fit: BoxFit.cover,
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
                  validator: (value) => _validateField(value, 'name'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
                child: TextFormFieldCustom(
                  controller: _emailController,
                  hintText: 'Email',
                  prefixIconPath: "assets/svg/email.svg",
                  validator: (value) => _validateField(value, 'email'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormFieldCustom(
                  controller: _passwordController,
                  isPassword: true,
                  hintText: 'Password',
                  prefixIconPath: "assets/svg/password.svg",
                  validator: (value) => _validateField(value, 'password'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16),
                child: TextFormFieldCustom(
                  controller: _confirmPasswordController,
                  isPassword: true,
                  hintText: "Confirm Password",
                  prefixIconPath: "assets/svg/password.svg",
                  validator: (value) => _validateField(value, 'confirmPassword'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormFieldCustom(
                  controller: _phoneController,
                  hintText: 'Phone Number',
                  prefixIconPath: "assets/svg/call.svg",
                  validator: (value) => _validateField(value, 'phone'),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
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
                            Navigator.of(context).pop();
                          },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ChangeLanguage(),
            ],
          ),
        ),
      ),
    );
  }
}
