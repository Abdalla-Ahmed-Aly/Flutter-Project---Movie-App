import 'package:flutter/material.dart';

class AppTheme {
  static Color primary = Color(0xffFFBB3B);
  static Color white = Color(0xffFFFEFF);
  static Color red = Color(0xffE82626);
  static Color black = Color(0xff121312);
  static Color gray = Color(0xff282A28);

  static ThemeData darktheme = ThemeData(
      scaffoldBackgroundColor: black,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: gray,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primary,
        unselectedItemColor: white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppTheme.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: AppTheme.primary),
        ),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: red,
            ),
            borderRadius: BorderRadius.circular(16)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: red,
            ),
            borderRadius: BorderRadius.circular(16)),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          color: white,
          fontSize: 36,
          fontFamily: 'myFonts',
          fontWeight: FontWeight.w500, //medium font
        ),
        displayMedium: TextStyle(
          color: white,
          fontSize: 24,
          fontFamily: 'myFonts',
          fontWeight: FontWeight.w700, // bold font
        ),
        displaySmall: TextStyle(
          color: white,
          fontSize: 20,
          fontFamily: 'myFonts',
          fontWeight: FontWeight.w700, // bold font
        ),
        titleLarge: TextStyle(
          color: white,
          fontSize: 20,
          fontFamily: 'myFonts',
          fontWeight: FontWeight.w600, // semi-bold font
        ),
        titleMedium: TextStyle(
          color: white,
          fontSize: 20,
          fontFamily: 'myFonts',
          fontWeight: FontWeight.w400, // regular font
        ),
        titleSmall: TextStyle(
          color: white,
          fontSize: 16,
          fontFamily: 'myFonts',
          fontWeight: FontWeight.w400, // regular font
        ),
        bodyLarge: TextStyle(
          color: white,
          fontSize: 14,
          fontFamily: 'myFonst',
          fontWeight: FontWeight.w400, // regular font
        ),
        bodyMedium: TextStyle(
          color: white,
          fontSize: 14,
          fontWeight: FontWeight.w900, // Black font
        ),
        bodySmall: TextStyle(
          color: white,
          fontSize: 15,
          fontFamily: 'myFonts',
          fontWeight: FontWeight.w400, // regular font
        ),
      ),
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
        foregroundColor: primary,
      )));
}
