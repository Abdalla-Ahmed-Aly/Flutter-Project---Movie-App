import 'package:flutter/material.dart';
import 'package:movieapp/core/widgets/customButton.dart';
import 'package:movieapp/features/Update_Profile/presentation/screens/update_profile.dart';

import '../../../../core/widgets/tab_bar_icon.dart';
import '../../../../theme/apptheme.dart';

class ProfileTab extends StatelessWidget {
  static const String routeName = "/ProfileTab";

  const ProfileTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 24),
          decoration: BoxDecoration(color: AppTheme.gray),
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset("assets/Avatar/gamer1.png"),
                        const SizedBox(height: 15),
                        Text("Marwan Atef", style: textTheme.displaySmall),
                      ],
                    ),
                    Column(
                      children: [
                        Text("12", style: textTheme.displayLarge),
                        const SizedBox(height: 15),
                        Text("Watch List", style: textTheme.displayMedium),
                      ],
                    ),
                    Column(
                      children: [
                        Text("10", style: textTheme.displayLarge),
                        const SizedBox(height: 15),
                        Text("History", style: textTheme.displayMedium),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: CustomButton(
                          buttonTitle: "Edit Profile",
                          buttonColor: AppTheme.primary,
                          onPressed: () {
                            Navigator.of(context).pushNamed(UpdateProfile.routeName);
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
                          onPressed: () {},
                          fontColor: AppTheme.white,
                          buttonTitleStyle: textTheme.titleMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                DefaultTabController(
                  length: 2,
                  child: TabBar(
                    indicatorColor: AppTheme.primary,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: const EdgeInsets.only(bottom: 17),
                    indicatorWeight: 3,
                    tabs: [
                      TabBarIcon(iconName: "watchlist", label: "Watch List"),
                       TabBarIcon(iconName: "file", label: "History"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Image.asset("assets/images/login_screen_header.png"),
         ),
      ],
    );
  }
}
