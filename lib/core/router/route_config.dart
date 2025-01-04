import 'package:flutter/material.dart';

import '../../page/base/page_404.dart';
import '../../page/base/scan_page.dart';
import '../../page/demo/demo_page.dart';
import '../../page/home/language_page.dart';
import '../../page/index_page.dart';
import 'models.dart';

typedef WidgetBuilder = Widget Function(Object? arguments);

class RouteConfig {
  static final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
    '/': (Object? arguments) => const IndexPage(),
    '/demo_page': (Object? arguments) => const DemoPage(),
    '/scan': (Object? arguments) => const ScanPage(),
    '/language': (Object? arguments) => const LanguagePage(),
  };

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    PageConfig? pageConfig = settings.arguments as PageConfig?;
    var arguments = pageConfig?.arguments;
    final Widget widget =
        routes[settings.name]?.call(arguments) ?? const Page404();
    return _buildRoute(widget, pageConfig?.transitionType);
  }

  // Builds a route with the specified transition type.
  static Route<dynamic>? _buildRoute(Widget widget, TransitionType? type) {
    switch (type) {
      case TransitionType.none:
        return NoAnimationPageRoute<Object?>(
          builder: (BuildContext context) => widget,
        );
      case TransitionType.fromRight:
        return MaterialPageRoute<Object?>(
          builder: (BuildContext context) => widget,
        );
      case TransitionType.fromLeft:
        return SlideFromLeftPageRoute<Object?>(
          builder: (BuildContext context) => widget,
        );
      case TransitionType.fromBottom:
        return FadeUpwardsPageRoute<Object?>(
          builder: (BuildContext context) => widget,
        );
      case TransitionType.zoomInOut:
        return ZoomPageRoute<Object?>(
          builder: (BuildContext context) => widget,
        );
      default:
        return MaterialPageRoute<Object?>(
          builder: (BuildContext context) => widget,
        );
    }
  }
}
