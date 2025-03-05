import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/utils/validator.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:movieapp/features/Update_Profile/data/models/avatar_model.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/core/widgets/cutomTextFormField.dart';
import 'package:movieapp/features/Update_Profile/presentation/screens/showAvatar.dart';

class UpdateProfile extends StatefulWidget {
  static const String routeName = '/update';

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int selectedAvatarIndex = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final _userData = context.read<AuthCubit>().userData;
    selectedAvatarIndex = _userData?.avaterId ?? 0;
    nameController.text = _userData?.name ?? '';
    phoneController.text = _userData?.phone?.replaceFirst("+2", "") ?? '';

    // print(_userData!.password);
  }

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
    int avatarIndex = selectedAvatarIndex;
    String avatarPath = Avatar.avatarPaths[avatarIndex].imagePath;
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
                          Navigator.of(context).pop();
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
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
                      avatarPath,
                      width: MediaQuery.sizeOf(context).width * 0.4,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(height: 35),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormFieldCustom(
                          hintText: 'Name',
                          prefixIconPath: 'assets/icons/UserIcon.svg',
                          validator: (value) =>
                              Validator.validateField(value, 'name'),
                          controller: nameController,
                        ),
                        SizedBox(height: 19),
                        TextFormFieldCustom(
                          hintText: 'Phone',
                          prefixIconPath: 'assets/icons/phoneicons.svg',
                          validator: (value) =>
                              Validator.validateField(value, 'phone'),
                          controller: phoneController,
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
      print(nameController.text);
      print(phoneController.text);
      print('Selected Avatar ID: $selectedAvatarIndex');
    }
  }
}
