import 'package:hb_router/utils/hb_router.dart';

import '../../page/demo/demo_page.dart';
import '../../page/home/language_page.dart';
import '../../page/index_page.dart';

class RouteConfig {
  static final Map<String, HbWidgetBuilder> routes = <String, HbWidgetBuilder>{
    '/': (Object? arguments) => const IndexPage(),
    '/demo_page': (Object? arguments) => const DemoPage(),
    '/language': (Object? arguments) => const LanguagePage(),
  };
}
