import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_cubit.dart';
import 'package:movieapp/features/Auth/presentation/cubit/auth_state.dart';
import 'package:movieapp/features/Auth/presentation/screens/login_screen.dart';
import 'package:movieapp/features/Profile/presentation/cubit/watch_cubit.dart';
import 'package:movieapp/features/Profile/presentation/screens/history_tab.dart';
import 'package:movieapp/features/Profile/presentation/screens/watch_list_tab.dart';
import 'package:movieapp/features/Update_Profile/data/models/avatar_model.dart';
import 'package:movieapp/features/Update_Profile/presentation/screens/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/widgets/tab_bar_icon.dart';
import '../../../../theme/apptheme.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = "/ProfileTab";

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  int currentIndex = 0;
  int watchListCount = 0;

  void updateWatchListCount(int count) {
    setState(() {
      watchListCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    int selectedAvatarIndex = 0;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit()..getData(),
        ),
        BlocProvider(
          create: (context) => WatchCubit()..getWatchList(),
        )
      ],
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
                                    Text("$watchListCount", style: textTheme.displayLarge),
                                    SizedBox(height: 5),
                                    Text("Watch List",
                                        style: textTheme.displayMedium),
                                  ],
                                ),
                                SizedBox(width: 40),
                                Column(
                                  children: [
                                    Text("${'50'}",
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
                                      onPressed: () async {
                                        SharedPreferences pref =
                                            await SharedPreferences
                                                .getInstance();
                                        pref.remove("authtoken");
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
                                indicatorSize: TabBarIndicatorSize.tab,
                                onTap: (currentTap) {
                                  if (currentIndex != currentTap) {
                                    setState(() {
                                      currentIndex = currentTap;
                                    });
                                  }
                                },
                                tabs: [
                                  TabBarIcon(
                                    iconName: "watchlist",
                                    label: "Watch List",
                                  ),
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
                  child: currentIndex == 0 ? WatchListTab(onWatchListUpdated: updateWatchListCount) : HistoryTab()),
            ],
          ),
        ),
      ),
    );
  }
}
