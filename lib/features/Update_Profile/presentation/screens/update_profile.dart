import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movieapp/core/utils/validator.dart';
import 'package:movieapp/features/Auth/data/models/data.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:movieapp/features/Auth/presentation/screens/forget_password_screen.dart';
import 'package:movieapp/features/Auth/presentation/screens/login_screen.dart';
import 'package:movieapp/features/Home_screen/presentation/screens/home_screen.dart';
import 'package:movieapp/features/Update_Profile/data/models/UpdateDataRequest.dart';
import 'package:movieapp/features/Update_Profile/data/models/avatar_model.dart';
import 'package:movieapp/features/Update_Profile/presentation/cubit/auth_cubit.dart';
import 'package:movieapp/theme/apptheme.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/core/widgets/cutomTextFormField.dart';
import 'package:movieapp/features/Update_Profile/presentation/screens/showAvatar.dart';

class UpdateProfile extends StatelessWidget {
  static const String routeName = '/update';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: UpdateProfileBody(),
    );
  }
}

class UpdateProfileBody extends StatefulWidget {
  @override
  _UpdateProfileBodyState createState() => _UpdateProfileBodyState();
}

class _UpdateProfileBodyState extends State<UpdateProfileBody> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  int selectedAvatarIndex = 0;
  String? avatarPath;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final _userData = context.read<AuthCubit>().userData;
    selectedAvatarIndex = _userData?.avaterId ?? 0;
    nameController.text = _userData?.name ?? '';
    phoneController.text = _userData?.phone?.replaceFirst("+2", "") ?? '';

    // print(_userData!.password);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ModalRoute.of(context)!.settings.arguments as Data;
      setState(() {
        selectedAvatarIndex = user.avaterId ?? 0;
        nameController.text = user.name!;
        phoneController.text = user.phone!.replaceFirst('+2', '');
        avatarPath = Avatar.avatarPaths[selectedAvatarIndex].imagePath;
      });
    });
  }

  Future<void> updateProfile() async {
    if (formKey.currentState!.validate()) {
      await context
          .read<UpdateAuthCubit>()
          .updateData(
            UpdateDataRequest(
              name: nameController.text,
              phone: '+2' + phoneController.text,
              avaterId: selectedAvatarIndex,
            ),
          )
          .then((_) {
        Navigator.of(context)
            .pushReplacementNamed(HomeScreen.routeName, arguments: 3);
      }).catchError((error) {
        print(error);
      });
    }
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
              avatarPath = Avatar.avatarPaths[selectedAvatarIndex].imagePath;
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                          Navigator.of(context).pop(true);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    Text(
                      'Pick Avatar',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: AppTheme.primary),
                    ),
                  ],
                ),
                SizedBox(height: 37),
                Center(
                  child: GestureDetector(
                    onTap: _showAvatarSelection,
                    child: avatarPath != null
                        ? Image.asset(
                            avatarPath!,
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            fit: BoxFit.fill,
                          )
                        : CircularProgressIndicator(),
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
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ResetPasswordScreen.routeName);
                          },
                          child: Text(
                            'Reset Password',
                            style: Theme.of(context).textTheme.titleMedium,
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
              onPressed: () {
                context.read<UpdateAuthCubit>().delete().then((onValue) {
                  Navigator.of(context)
                      .pushReplacementNamed(LoginScreen.routeName);
                });
              },
            ),
            SizedBox(height: 10),
            CustomButton(
              buttonTitle: 'Update Data',
              buttonColor: AppTheme.primary,
              fontColor: AppTheme.black,
              onPressed: updateProfile,
            ),
          ],
        ),
      ),
    );
  }
}
