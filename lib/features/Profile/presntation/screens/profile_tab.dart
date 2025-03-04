import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_state.dart';
import 'package:movieapp/features/Auth/presentation/screens/login_screen.dart';
import 'package:movieapp/features/Update_Profile/data/models/avatar_model.dart';
import 'package:movieapp/features/Update_Profile/presentation/screens/update_profile.dart';
import '../../../../core/widgets/tab_bar_icon.dart';
import '../../../../theme/apptheme.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = "/ProfileTab";

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    int selectedAvatarIndex = 0;

    return BlocProvider(
      create: (context) => AuthCubit()..getData(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 24),
                decoration: BoxDecoration(color: AppTheme.gray),
                child: SafeArea(
                  child: BlocBuilder<AuthCubit, AuthState>(
                    builder: (_, state) {
                      if (state is AuthLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (state is AuthError) {
                        Fluttertoast.showToast(msg: state.message);
                        return Center(child: Text("Error loading profile"));
                      }

                      if (state is AuthDataSuccess) {
                        final user = state.dataResponse.data!;
                        selectedAvatarIndex = user.avaterId ?? 0;

                        String avatarPath =
                            Avatar.avatarPaths[selectedAvatarIndex].imagePath;

                        return Column(
                          children: [
                            CircleAvatar(
                              radius: 60,
                              backgroundImage: AssetImage(avatarPath),
                            ),
                            const SizedBox(height: 10),
                            Text(user.name!, style: textTheme.displaySmall),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Text("${''}",
                                        style: textTheme.displayLarge),
                                    SizedBox(height: 5),
                                    Text("Wish List",
                                        style: textTheme.displayMedium),
                                  ],
                                ),
                                SizedBox(width: 40),
                                Column(
                                  children: [
                                    Text("${''}",
                                        style: textTheme.displayLarge),
                                    SizedBox(height: 5),
                                    Text("History",
                                        style: textTheme.displayMedium),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: CustomButton(
                                      buttonTitle: "Edit Profile",
                                      buttonColor: AppTheme.primary,
                                      onPressed: () async {
                                        final result =
                                            await Navigator.pushNamed(
                                          context,
                                          UpdateProfile.routeName,
                                          arguments: user,
                                        );
                                      },
                                      fontColor: AppTheme.black,
                                      buttonTitleStyle: textTheme.titleMedium,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: CustomButton(
                                      buttonTitle: "Exit",
                                      buttonColor: AppTheme.red,
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                                LoginScreen.routeName);
                                      },
                                      fontColor: AppTheme.white,
                                      buttonTitleStyle: textTheme.titleMedium,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: TabBar(
                                indicatorColor: AppTheme.primary,
                                indicatorWeight: 3,
                                labelPadding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                tabs: [
                                  TabBarIcon(
                                      iconName: "watchlist",
                                      label: "Watch List"),
                                  TabBarIcon(
                                      iconName: "file", label: "History"),
                                ],
                              ),
                            ),
                          ],
                        );
                      }

                      return SizedBox();
                    },
                  ),
                ),
              ),
              Expanded(
                child: Image.asset("assets/images/login_screen_header.png"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
