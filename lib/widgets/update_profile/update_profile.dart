import 'package:flutter/material.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/widgets/Auth/login_screen.dart';
import 'package:movieapp/widgets/common_widgets/customButton.dart';
import 'package:movieapp/widgets/common_widgets/cutomTextFormField.dart';
import 'package:movieapp/widgets/update_profile/showAvatar.dart';

class UpdateProfile extends StatefulWidget {
  static const String routeName = '/update';

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  int selectedAvatarIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

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

  void _showAvatarSelection() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16),
        child: ShowAvatar(
          selectedAvatarIndex: selectedAvatarIndex,
          onAvatarSelected: (index) {
            setState(() {
              selectedAvatarIndex = index;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          color: AppTheme.primary,
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          icon: Icon(Icons.arrow_back),
                        )),
                    Text(
                      'Pick Avatar',
                      style: textTheme.titleSmall
                          ?.copyWith(color: AppTheme.primary),
                    ),
                  ],
                ),
                SizedBox(height: 37),
                Center(
                  child: GestureDetector(
                    onTap: _showAvatarSelection,
                    child: Image.asset(
                      avatarPaths[selectedAvatarIndex],
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Expanded(
                  child: SingleChildScrollView(
                    // keyboardDismissBehavior:
                    //     ScrollViewKeyboardDismissBehavior.onDrag,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldCustom(
                          hintText: 'Name',
                          prefixIconPath: 'assets/icons/UserIcon.svg',
                          validator: (value) {
                            if (value == null || value.length < 5) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 19),
                        TextFormFieldCustom(
                          hintText: 'Phone',
                          prefixIconPath: 'assets/icons/phoneicons.svg',
                          validator: (value) {
                            if (value == null || value.length < 5) {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 19),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            'Reset Password',
                            style: textTheme.titleMedium,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: AppTheme.black,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomButton(
              buttonTitle: 'Delete Account',
              buttonColor: AppTheme.red,
              fontColor: AppTheme.white,
              onPressed: () {},
            ),
            SizedBox(height: 10),
            CustomButton(
              buttonTitle: 'Update Data',
              buttonColor: AppTheme.primary,
              fontColor: AppTheme.black,
              onPressed: () {
                login();
              },
            ),
          ],
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      Navigator.of(context).pushReplacementNamed(UpdateProfile.routeName);
    }
  }
}
