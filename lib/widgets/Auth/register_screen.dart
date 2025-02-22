import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/widgets/common_widgets/customButton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../common_widgets/cutomTextFormField.dart';

class Signup extends StatefulWidget {
  static const String routeName = "signup";

  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  int _selectedAvatar = 0;
  bool _isObscured = true;
  bool _isConfirmObscured = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadAvatar();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _centerToAvatar(_selectedAvatar));
  }

  // Load saved avatar from SharedPreferences
  void _loadAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedAvatar = prefs.getInt('selectedAvatar') ?? 0;
    });
  }

  // Save selected avatar to SharedPreferences
  void _saveAvatar(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedAvatar', index);
  }

  // Center to selected avatar
  void _centerToAvatar(int index) {
    final double offset = (index * 100).toDouble();
    _scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> avatarImages = [
      'assets/svg/avatar1.svg',
      'assets/svg/avatar2.svg',
      'assets/svg/avatar3.svg',
      'assets/svg/avatar4.svg',
      'assets/svg/avatar5.svg',
      'assets/svg/avatar6.svg',
      'assets/svg/avatar7.svg',
      'assets/svg/avatar8.svg',
      'assets/svg/avatar9.svg',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Register'),
        foregroundColor: Colors.amber,
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            SizedBox(
              height: 120,
              child: ListView.builder(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                itemCount: avatarImages.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedAvatar = index;
                      });
                      _saveAvatar(index);
                      _centerToAvatar(index);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      padding: EdgeInsets.all(_selectedAvatar == index ? 4 : 0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: _selectedAvatar == index
                            ? Border.all(color: Colors.amber, width: 3)
                            : null,
                      ),
                      child: CircleAvatar(
                        radius: _selectedAvatar == index ? 50 : 30,
                        backgroundColor: Colors.transparent,
                        child: SvgPicture.asset(
                          avatarImages[index],
                          width: _selectedAvatar == index ? 100 : 60,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Avatar",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextFormFieldCustom(
              hintText: 'Name',
              iconSVGpath: "assets/svg/name.svg",
            ),
            TextFormFieldCustom(
              hintText: 'Email',
              iconSVGpath: "assets/svg/email.svg",
            ),
            TextFormFieldCustom(
              isObscured: _isObscured,
              hintText: 'Password',
              iconSVGpath: "assets/svg/password.svg",
              sufIcon: IconButton(
                icon: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
              ),
            ),
            TextFormFieldCustom(
              isObscured: _isConfirmObscured,
              hintText: "Confirm Password",
              iconSVGpath: "assets/svg/password.svg",
              sufIcon: IconButton(
                icon: Icon(
                  _isConfirmObscured ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isConfirmObscured = !_isConfirmObscured;
                  });
                },
              ),
            ),
            TextFormFieldCustom(
              hintText: 'Phone Number',
              iconSVGpath: "assets/svg/call.svg",
            ),
            const SizedBox(height: 10),
            CustomButton(
              buttonTitle: 'Create Account',
              buttonColor: Colors.amber,
              fontColor: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: RichText(
                text: TextSpan(
                  text: 'Already Have Account? ',
                  style: const TextStyle(
                    fontSize: 14,
                    letterSpacing: 0.7,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
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
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 165.0, vertical: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.amber),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.amber,
                        ),
                        child: Image.asset('assets/images/LR.png', width: 30),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black,
                        ),
                        child: Image.asset('assets/images/EG.png', width: 30),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
