import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movieapp/core/LocalizationCubit.dart';
import 'package:movieapp/theme/apptheme.dart';

enum Language { en, eg }

class ToggleSwitcher extends StatelessWidget {
  final flagAssets = {
    Language.en: 'assets/icons/en.svg',
    Language.eg: 'assets/icons/eg.svg',
  };

  @override
  Widget build(BuildContext context) {
    var screendim = MediaQuery.sizeOf(context);
    return BlocBuilder<LocalizationCubit, Locale>(
      builder: (context, locale) {
        Language selectedLanguage =
            locale.languageCode == 'en' ? Language.en : Language.eg;

        return AnimatedToggleSwitch<Language>.rolling(
          current: selectedLanguage,
          values: const [Language.en, Language.eg],
          onChanged: (value) {
            String newLocale = value == Language.en ? 'en' : 'ar';

            context.read<LocalizationCubit>().changeLanguage(newLocale);
          },
          iconBuilder: (value, isActive) {
            return SvgPicture.asset(
              flagAssets[value]!,
              width: 32,
              height: 32,
            );
          },
          indicatorSize: const Size(40, 40),
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
      },
    );
  }
}
