import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/theme/apptheme.dart';

class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final Color buttonColor;
  final Color fontColor;
  final Color? borderSideColor;
  final bool notFillColor;
  final String? iconPath;
  final VoidCallback onPressed;

  const CustomButton({
    super.key,
    required this.buttonTitle,
    required this.buttonColor,
    required this.fontColor,
    this.borderSideColor,
    this.notFillColor = false,
    this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor:
        MaterialStatePropertyAll(notFillColor ? Colors.black : buttonColor),
        fixedSize: MaterialStatePropertyAll(
          Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.07),
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side: BorderSide(color: borderSideColor ?? AppTheme.primary),
          ),
        ),
      ),
      onPressed: onPressed,
      icon: iconPath != null
          ? SvgPicture.asset(
        iconPath!,
        height: 24,
        width: 24,
      )
          : const SizedBox(),
      label: Text(
        buttonTitle,
        style: TextStyle(
          color: notFillColor ? Colors.amber : fontColor,
          fontSize: 20,
        ),
      ),
    );
  }
}