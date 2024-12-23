import 'package:flutter/material.dart';

import '../../page/base/page_404.dart';
import '../../page/demo/demo_page.dart';
import '../../page/index_page.dart';

typedef WidgetBuilder = Widget Function(Object? arguments);

class RouteConfig {
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/': (Object? arguments) => const IndexPage(),
    '/demo_page': (Object? arguments) => const DemoPage()
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final Widget widget =
        routes[settings.name]?.call(settings.arguments) ?? const Page404();
    return MaterialPageRoute<Object?>(
      builder: (BuildContext context) => widget,
    );
  }
}
