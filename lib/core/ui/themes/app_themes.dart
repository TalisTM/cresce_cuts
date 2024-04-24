import 'package:flutter/material.dart';

class AppThemes {
  AppThemes._();

  static const primary = Color(0xFF007FBA);
  static const black = Color(0xFF403E43);
  static const darkBlue = Color(0xFF455A64);
  static const white = Color(0xFFFFFFFF);
  static const lightGrey = Color(0xFFDEDEDE);
  static const red = Color(0xFFBA0000);

  static ThemeData get lightTheme => ThemeData(
        primaryColorLight: primary,
        brightness: Brightness.light,
        useMaterial3: false,
        primaryColor: primary,
        fontFamily: 'poppins',
        appBarTheme: const AppBarTheme(
          backgroundColor: white,
          elevation: 0.8,
          shadowColor: primary,
          centerTitle: true,
          iconTheme: IconThemeData(color: primary),
          titleTextStyle: TextStyle(
            color: black,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(primary),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            minimumSize: const Size(0, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            textStyle: const TextStyle(
              color: white,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: lightGrey, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
}
