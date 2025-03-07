import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class TabBarIcon extends StatelessWidget {
  TabBarIcon({super.key, required this.iconName, required this.label});
  String iconName;
  String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          "assets/icons/$iconName.svg",
          height: 24,
          width: 24,
          fit: BoxFit.scaleDown,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
