import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movieapp/theme/apptheme.dart';

enum Language { en, eg }

class ToggleSwitcher extends StatefulWidget {
  const ToggleSwitcher({
    super.key,
  });

  @override
  State<ToggleSwitcher> createState() => _ToggleSwitcherState();
}

class _ToggleSwitcherState extends State<ToggleSwitcher> {
  Language selectetLanguage = Language.en;
  final flagAssets = {
    Language.en: 'assets/icons/en.svg',
    Language.eg: 'assets/icons/eg.svg',
  };
  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.sizeOf(context);
    return AnimatedToggleSwitch<Language>.rolling(
      current: selectetLanguage,
      values: const [Language.en, Language.eg],
      onChanged: (value) {
        setState(() => selectetLanguage = value);
      },
      iconBuilder: (value, isActive) {
        return SvgPicture.asset(
          flagAssets[value]!,
          width: 32,
          height: 32,
        );
      },
      indicatorSize: Size(40, 40),
      style: ToggleStyle(
        backgroundColor: AppTheme.black,
        indicatorColor: AppTheme.primary,
        indicatorBorderRadius: BorderRadius.circular(30),
        borderColor: AppTheme.primary,
        borderRadius: BorderRadius.circular(30),
      ),
      spacing: 15,
      height: screendim.height * 0.052,
    );
  }
}
