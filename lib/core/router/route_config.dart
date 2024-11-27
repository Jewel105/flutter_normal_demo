import 'package:flutter/material.dart';

import '../../ui/page/base/page_404.dart';
import '../../ui/page/index_page.dart';
import '../../ui/page/login/login_page.dart';

typedef WidgetBuilder = Widget Function(Object? arguments);

class RouteConfig {
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/': (Object? arguments) => const IndexPage(),
    '/login': (Object? arguments) => const LoginPage(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final Widget widget =
        routes[settings.name]?.call(settings.arguments) ?? const Page404();
    return MaterialPageRoute<Object?>(
      builder: (BuildContext context) => widget,
    );
  }
}
