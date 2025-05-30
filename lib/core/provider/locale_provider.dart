import 'package:flutter/material.dart';
import 'package:hb_common/utils/index.dart';

import '../app/app_constant.dart';

class LocaleInfo {
  final String code;
  final String name;
  final Locale locale;
  LocaleInfo({required this.code, required this.name}) : locale = Locale(code);
}

class LocaleProvider extends ChangeNotifier {
  // 如需添加语言，仅需两步，1.locales中添加键值对即可，2.在lib/core/l10n添加对应的翻译文本
  // if you want to add a language, just add a key-value pair in locales and add corresponding translations in lib/core/l10n
  final Map<String, LocaleInfo> locales = {
    'en': LocaleInfo(code: 'en', name: 'English'),
    'hi': LocaleInfo(code: 'hi', name: 'हिन्दी'),
    'pt': LocaleInfo(code: 'pt', name: 'Português'),
    'zh': LocaleInfo(code: 'zh', name: '中文简体'),
  };

  String _locale = '';
  Locale? get locale {
    _locale = HbStorage.get(AppConstant.LOCALE) ?? "system";
    return locales[_locale]?.locale;
  }

  changeLanguage(String val) async {
    if (val == _locale) return;
    _locale = val;
    await HbStorage.set(AppConstant.LOCALE, val);
    notifyListeners();
  }
}
