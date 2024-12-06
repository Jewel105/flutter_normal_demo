import 'package:flutter/material.dart';

import 'app_color.dart';

class AppTheme {
  /// Main light theme for the app
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: AppColor.mainColor,
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
  );
}
