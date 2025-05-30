import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hb_common/app/hb_color.dart';
import 'package:hb_common/app/hb_style.dart';

class AppTheme {
  /// Main light theme for the app
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: HbColor.mainDarkColor,
    ),
    textTheme: TextTheme(bodyMedium: HbStyle.text14),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: HbColor.textBlack,
      ),
      elevation: 0, // Remove shadow under AppBar (去除 AppBar 下方的阴影)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: HbColor.textBlack,
      selectedItemColor: ColorScheme.fromSeed(
        brightness: Brightness.light,
        seedColor: HbColor.mainDarkColor,
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
      seedColor: HbColor.mainLightColor,
    ),
    textTheme: TextTheme(bodyMedium: HbStyle.text14),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        color: HbColor.textWhite,
      ),
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: HbColor.textWhite,
      selectedItemColor: ColorScheme.fromSeed(
        brightness: Brightness.dark,
        seedColor: HbColor.mainLightColor,
      ).primary,
    ),
  );
}
