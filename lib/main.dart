import 'package:flutter/material.dart';
import 'package:flutter_normal_demo/core/app/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hb_common/hb_common.dart';
import 'package:hb_router/utils/hb_router.dart';
import 'package:provider/provider.dart';

import 'core/app/app_theme.dart';
import 'core/provider/app_provider.dart';
import 'core/provider/locale_provider.dart';
import 'core/router/index.dart';
import 'gen/i18n/app_localizations.dart';

void main() {
  final errorReport = HbErrorReport(
    reportError: (error, stackTrace) {
      // TODO: Implement error reporting logic here
    },
  );
  // Run the app within the error-handling zone
  errorReport.errorHandlingZone.run(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // 初始化hb颜色
    AppColor.init();
    // Initialize utilities
    await Future.wait([
      // Initialize HbStorage
      HbStorage.init(),
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
                    onGenerateRoute: HbRouter(
                      RouteConfig.routes,
                    ).generateRoute,
                    navigatorKey: HbRouter.key,
                    builder: HbDialog.setup(),
                    navigatorObservers: [HbDialog.navigatorObservers],
                    locale: locale,
                    localizationsDelegates: const [
                      ...AppLocalizations.localizationsDelegates,
                      ...HbCommonLocalizations.localizationsDelegates,
                    ],
                    supportedLocales: AppLocalizations.supportedLocales,
                  );
                }),
          ),
        );
      },
    );
  }
}
