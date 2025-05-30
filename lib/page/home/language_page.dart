import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hb_common/hb_common.dart';
import 'package:provider/provider.dart';

import '../../core/provider/locale_provider.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HbAppBar(
        titleName: "LanguagePage",
      ),
      body: Consumer<LocaleProvider>(builder: (context, localeProvider, _) {
        var currentLocale = Localizations.localeOf(context);
        return Column(
          children: localeProvider.locales.values.map((e) {
            return Row(
              children: [
                e.name.text16w600().expanded,
                if (e.code == currentLocale.languageCode)
                  const Icon(Icons.check),
              ],
            ).py(8.w).px(16.w).onInkTap(() {
              localeProvider.changeLanguage(e.code);
            });
          }).toList(),
        );
      }),
    );
  }
}
