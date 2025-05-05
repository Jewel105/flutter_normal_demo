import 'package:flutter/material.dart';

import '../../gen/i18n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  AppLocalizations get locale => AppLocalizations.of(this);
}
