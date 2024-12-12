import 'package:flutter/foundation.dart';
import 'package:flutter_normal_demo/core/db/table/test_service.dart';

import 'db_provider.dart';

class SqliteUtil {
  static Future<void> forFeature() async {
    await DbProvider.initDatabase();
    List<DbProvider> list = [
      TestService(),
      //...其他的表实例
    ];
    // 检查表都创建完成
    for (DbProvider e in list) {
      while (!e.exists) {
        debugPrint("表还未创建完成 $e");
        try {
          // 每50毫秒检查一次表是否创建完成
          await Future.delayed(const Duration(milliseconds: 50));
        } catch (e) {
          break;
        }
      }
    }
    debugPrint("所有表创建完成");
  }
}
