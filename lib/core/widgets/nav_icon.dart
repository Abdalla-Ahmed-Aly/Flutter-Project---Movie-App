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
      height: MediaQuery.of(context).size.height * 0.025,
      width: 24,
    );
  }
}
