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
      seedColor: AppColor.mainColor,
    ),
    textTheme: TextTheme(bodyMedium: AppStyle.text14),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: AppStyle.text16W600Black,
      elevation: 0, // Remove shadow under AppBar (去除 AppBar 下方的阴影)
    ),
  );

  /// Main dark theme for the app
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: AppColor.mainColor,
    ),
    textTheme: TextTheme(bodyMedium: AppStyle.text14),
    appBarTheme: AppBarTheme(
      centerTitle: true,
      titleTextStyle: AppStyle.text16W600White,
      elevation: 0,
    ),
  );
}
