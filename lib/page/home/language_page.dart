import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../core/extensions/index.dart';
import '../../core/provider/locale_provider.dart';
import '../../widget/top_app_bar.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopAppBar(
        titleName: "LanguagePage",
      ),
      body: Consumer<LocaleProvider>(builder: (context, localeProvider, _) {
        var currentLocale = Localizations.localeOf(context);
        return Column(
          children: localeProvider.locales.values.map((e) {
            return Row(
              children: [
                e.name.text16W600.expanded,
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
