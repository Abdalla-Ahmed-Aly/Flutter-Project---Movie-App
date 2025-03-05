import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavIcon extends StatelessWidget {
  String imageIcon;
  NavIcon({required this.imageIcon});
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/${imageIcon}.svg",
      fit: BoxFit.scaleDown,
      height: 24,
      width: 24,
    );
  }
}
