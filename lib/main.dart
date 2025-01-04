import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/app/app_theme.dart';
import 'core/provider/app_provider.dart';
import 'core/provider/locale_provider.dart';
import 'core/router/index.dart';
import 'core/utils/index.dart';

void main() {
  final errorReport = ErrorReportUtil();
  // Run the app within the error-handling zone
  errorReport.errorHandlingZone.run(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // Initialize utilities
    await Future.wait([
      // Initialize StorageUtil
      StorageUtil.init(),
      // Wait for ScreenUtil to initialize itself.
      ScreenUtil.ensureScreenSize(),
      // SqliteUtil.forFeature(); //sqlite initialization
    ]);
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  /// Unfocus the currently focused widget when the screen is tapped
  void unfocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) {
        return GestureDetector(
          onTap: () => unfocus(context),
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AppProvider()),
              ChangeNotifierProvider(create: (_) => LocaleProvider()),
            ],
            child: Selector<LocaleProvider, Locale?>(
                selector: (context, provider) => provider.locale,
                builder: (context, locale, _) {
                  return MaterialApp(
                    title: 'Flutter Demo',
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: ThemeMode.system,
                    onGenerateRoute: RouteConfig.generateRoute,
                    navigatorKey: navigatorKey,
                    locale: locale,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                  );
                }),
          ),
        );
      },
    );
  }
}
