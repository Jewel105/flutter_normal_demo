import 'package:flutter/material.dart';

extension EmptyExtension on String? {
  bool get isEmptyOrNull => this == null || this!.isEmpty || this == '';
}

extension StringExtension on String {
  Color get toColor {
    return Color(int.parse(replaceAll("#", ""), radix: 16) + 0xFF000000);
  }
}
