import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movieapp/theme/apptheme.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  final String buttonTitle;
  final Color buttonColor;
  final Color? fontColor;
  final Color? borderSideColor;
  final bool notFillColor;
  final String? iconPath;
  final VoidCallback onPressed;
  final TextStyle? buttonTitleStyle;
  IconAlignment iconAlignment;

  CustomButton(
      {super.key,
      required this.buttonTitle,
      required this.buttonColor,
      this.fontColor,
      this.notFillColor = false,
      this.borderSideColor,
      this.iconPath,
      this.buttonTitleStyle,
      required this.onPressed,
      this.iconAlignment = IconAlignment.start});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor:
            WidgetStatePropertyAll(notFillColor ? Colors.black : buttonColor),
        fixedSize: WidgetStatePropertyAll(
          Size(MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height * 0.07),
        ),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            side: BorderSide(
              color: borderSideColor == null ? buttonColor : borderSideColor!,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
      icon: iconPath != null
          ? SvgPicture.asset(
              iconPath!,
              height: 26.56,
              width: 26.56,
            )
          : const SizedBox(),
      label: Text(buttonTitle,
          style: buttonTitleStyle == null
              ? Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: notFillColor ? AppTheme.primary : fontColor!,
                  )
              : buttonTitleStyle!),
      iconAlignment: iconAlignment,
    );
  }
}
