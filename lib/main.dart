import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/app/app_theme.dart';
import 'core/provider/app_provider.dart';
import 'core/router/index.dart';
import 'core/utils/index.dart';

void main() {
  final errorReport = ErrorReportUtil();
  // Run the app within the error-handling zone
  errorReport.errorHandlingZone.run(() async {
    WidgetsFlutterBinding.ensureInitialized();
    // SqliteUtil.forFeature();
    // Initialize utilities
    await StorageUtil.init();
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

  // 等待短暂的时间,确保ScreenUtil初始化完成,解决release模式下text不展示问题
  // Wait for ScreenUtil to initialize itself.
  Future initialiseScreenUtil() async {
    await Future.delayed(Durations.short2);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initialiseScreenUtil(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          }
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
                  ],
                  child: MaterialApp(
                    title: 'Flutter Demo',
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: ThemeMode.dark,
                    onGenerateRoute: RouteConfig.generateRoute,
                    navigatorKey: navigatorKey,
                    localizationsDelegates:
                        AppLocalizations.localizationsDelegates,
                    supportedLocales: AppLocalizations.supportedLocales,
                  ),
                ),
              );
            },
          );
        });
  }
}
