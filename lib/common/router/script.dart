import 'dart:io';

/// Generate routes config
/// 自动生成routes脚本
void main() {
  // get the current router directory
  // 获取路由文件内容
  var path = './lib/common/router/route_config.dart';
  var res = File(path).readAsStringSync();

  // Parse the router file to extract the route names
  // 提取路由名称
  RegExp regExp = RegExp("['\"]/(.*?)['\"]: ");
  Iterable<Match> matches = regExp.allMatches(res);
  var list = matches.map((match) => match.group(1)).toList();

  final String s = list.map((e) {
    if (e?.isEmpty ?? true) {
      return "  static const String index = '/$e';";
    }
    if (e!.contains('_')) {
      List<String> listStr = e.split('_');
      String result = listStr[0];
      for (var i = 1; i < listStr.length; i++) {
        result += listStr[i][0].toUpperCase() + listStr[i].substring(1);
      }
      e = result;
    }
    return "  static const String $e = '/$e';";
  }).join('\n');

  // Generate template code
  // 替换模版
  String template = '''
class Routes {
%s
}
''';
  template = template.replaceAll("%s", s);

  // Write the generated routes into a routes.dart
  // 写入文件
  File('./lib/common/router/routes.dart').writeAsStringSync(template);
}
