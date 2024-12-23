import 'package:flutter/material.dart';

import '../app/app_style.dart';

extension TextExtension on String {
  Text get text16W600 {
    return Text(
      this,
      style: AppStyle.text16W600,
    );
  }
}
