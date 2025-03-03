import 'package:flutter/material.dart';

import '../../../../core/widgets/nav_icon.dart';
import '../../../../theme/apptheme.dart';
import '../../../Browse/presentation/screens/browse_tab.dart';
import '../../../Home/presentation/screens/Home_tab.dart';
import '../../../Profile/presntation/screens/profile_tab.dart';
import '../../../Search/presentation/screens/search_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "/home";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final List<Widget> tabs = [
    HomeTab(),
    SearchTab(),
    BrowseTab(),
    ProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: SafeArea(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppTheme.gray,
            elevation: 0,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            currentIndex: currentIndex,
            onTap: (value) {
              if (currentIndex != value) {
                setState(() {
                  currentIndex = value;
                });
              }
            },
            items: [
               BottomNavigationBarItem(
                icon: NavIcon(imageIcon: "home"),
                activeIcon: NavIcon(imageIcon: "homeActive"),
                label: "Home",
              ),
               BottomNavigationBarItem(
                icon: NavIcon(imageIcon: "search"),
                activeIcon: NavIcon(imageIcon: "searchActive"),
                label: "Search",
              ),
               BottomNavigationBarItem(
                icon: NavIcon(imageIcon: "browse"),
                activeIcon: NavIcon(imageIcon: "browseActive"),
                label: "Browse",
              ),
              BottomNavigationBarItem(
                icon: NavIcon(imageIcon: "profile"),
                activeIcon:  NavIcon(imageIcon: "profileActive"),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
