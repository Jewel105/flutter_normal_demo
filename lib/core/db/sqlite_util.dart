import 'package:flutter/foundation.dart';

import 'db_provider.dart';
import 'table/test_table.dart';

class SqliteUtil {
  static Future<void> forFeature() async {
    await DbProvider.initDatabase();
    List<DbProvider> list = [
      TestTable(),

      // ... Other tables
      //... 其他的表实例
    ];
    // Check table exists
    // 检查表都创建完成
    for (DbProvider e in list) {
      while (!e.exists) {
        debugPrint("表还未创建完成 $e");
        debugPrint("table name: ${e.tableName}");
        try {
          // 每50毫秒检查一次表是否创建完成
          // Every 50 milliseconds check the table status
          await Future.delayed(const Duration(milliseconds: 50));
        } catch (e) {
          break;
        }
      }
    }
    debugPrint("All tables created");
    debugPrint("所有表创建完成");
  }
}
