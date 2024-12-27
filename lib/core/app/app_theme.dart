import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_style.dart';

class AppTheme {
  /// Main light theme for the app
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: AppColor.mainDarkColor,
    ),
    textTheme: TextTheme(bodyMedium: AppStyle.text14),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: AppStyle.text16W600Black,
      elevation: 0, // Remove shadow under AppBar (去除 AppBar 下方的阴影)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: AppColor.textBlack,
      selectedItemColor: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: AppColor.mainDarkColor,
      ).primary,
      type: BottomNavigationBarType.fixed,
    ),
  );

  /// Main dark theme for the app
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColor.mainLightColor,
    ),
    textTheme: TextTheme(bodyMedium: AppStyle.text14),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: AppStyle.text16W600White,
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: AppColor.textWhite,
      selectedItemColor: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: AppColor.mainLightColor,
      ).primary,
    ),
  );
}
