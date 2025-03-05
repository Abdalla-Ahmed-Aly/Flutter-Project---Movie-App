import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class NavIcon extends StatelessWidget {
  String imageIcon;
  NavIcon({super.key, required this.imageIcon});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$imageIcon.svg",
      fit: BoxFit.scaleDown,
      height: 24,
      width: 24,
    );
  }
}
