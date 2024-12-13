import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

abstract class DbProvider {
  static const String _dbName = "flutter_normal_demo"; // 数据库名称 // Database name
  static const int _version = 1; // 数据库版本号 // Database version
  static late String _dbBasePath; // 数据库路径 // Database path
  static bool _needRefresh =
      false; // 数据库需要更新 // Indicates if the database needs to be refreshed
  static Database? _db; // 数据库实例 // Database instance

  /// 数据库实例化完成后的操作
  /// Operations after the database initialization is complete
  static onReload(Database db) async {
    if (_needRefresh) {
      try {
        // TODO 此处编写更新数据库的脚本 // Write database update scripts here
      } catch (e) {
        debugPrint("Database upgrade error-------$e"); // Database upgrade error
      }
    }
  }

  /// 表名称 // Table name
  abstract String tableName;

  /// 表是否存在 // Indicates if the table exists
  bool exists = false;

  /// 创建表 // Create table
  Future<void> onCreate(Database db, int version);

  DbProvider() {
    debugPrint(
        "Creating table - parent class"); // Creating table - parent class
    if (_db == null) {
      initDatabase().then((db) {
        _db = db;
        _initTable();
      });
    } else {
      _initTable();
    }
  }

  /// 创建数据库 // Initialize database
  static Future<Database> initDatabase() async {
    _dbBasePath = "${await getDatabasesPath()}/$_dbName.db";
    debugPrint("Opening database, database path:");
    debugPrint(_dbBasePath);

    // 打开数据库 // Open the database
    _db = await openDatabase(
      _dbBasePath,
      version: _version,
      onUpgrade: (db, old, newV) {
        _needRefresh = true;
        debugPrint("Database upgraded"); // Database upgraded
      },
      onDowngrade: (db, old, newV) {
        _needRefresh = true;
        debugPrint("Database downgraded"); // Database downgraded
      },
    );
    await onReload(_db!);
    return _db!;
  }

  /// 创建表 // Create table
  Future<void> _initTable() async {
    // 内建表sqlite_master // Built-in table sqlite_master
    // Check if the table exists
    var res = await _db!.rawQuery(
      "SELECT * FROM sqlite_master WHERE TYPE = 'table' AND NAME = '$tableName'",
    );
    if (res.isEmpty) {
      debugPrint(
          "Table does not exist, creating table"); // Table does not exist, creating table
      await onCreate(_db!, _version);
    }
    exists = true;
  }

  /// 表列是否存在 // Check if a table column exists
  Future<bool> columnExists(String columnName) async {
    var result = await _db!.rawQuery("""
      SELECT *
      FROM sqlite_master
      WHERE type = 'table' AND name='$tableName' AND sql LIKE '%$columnName%';
    """);
    return result.isNotEmpty;
  }

  /// 新增列 // Add a new column
  Future addColumn(String columnName, String type) async {
    return await _db!.rawQuery("""
      ALTER TABLE $tableName ADD $columnName $type
    """);
  }

  /// 删表 // Drop table
  Future<void> dropTable() async {
    return await _db!.execute("""
      DROP TABLE IF EXISTS $tableName;
    """);
  }

  /// 插入数据 // Insert data
  Future<int> insert(Map<String, dynamic> data) async {
    return _db!.insert(tableName, data);
  }

  /// 删除数据, 使用whereArgs预防SQL注入 // Delete data, use whereArgs to prevent SQL injection
  Future<int> delete(Map<String, Object?> where) async {
    List<String> keys = where.keys.toList();
    List<Object?> whereArgs = where.values.toList();
    return _db!.delete(
      tableName,
      where: keys.isEmpty ? null : "${keys.join(" = ? AND ")} = ?",
      whereArgs: whereArgs,
    );
  }

  /// 修改数据 // Update data
  Future<int> update(
      Map<String, Object?> where, Map<String, dynamic> data) async {
    List<String> keys = where.keys.toList();
    List<Object?> whereArgs = where.values.toList();
    return _db!.update(
      tableName,
      data,
      where: keys.isEmpty ? null : "${keys.join(" = ? AND ")} = ?",
      whereArgs: whereArgs,
    );
  }

  /// 查找数据 // Query data
  Future<List<dynamic>> find({
    Map<String, Object?>? where,
    int? page,
    int pageSize = 20,
    String? orderBy,
    String? groupBy,
  }) async {
    List<String> keys = where?.keys.toList() ?? [];
    List<Object?> whereArgs = where?.values.toList() ?? [];
    List<Object?> whereArgsCopy = List.from(whereArgs);
    for (var element in whereArgsCopy) {
      if (element == null) {
        var index = whereArgs.indexOf(element);
        keys.removeAt(index);
        whereArgs.remove(element);
      }
    }
    String? sql = keys.isEmpty ? null : "${keys.join(" = ? AND ")} = ?";
    if (keys.length == 1 && whereArgs.first is List) {
      sql = "${keys.first} IN (?, ?, ?)";
      whereArgs = whereArgs.first as List<Object?>;
    }
    return await _db!.query(
      tableName,
      where: sql,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
      groupBy: groupBy,
      offset: page == null ? null : (page - 1) * pageSize,
      limit: page == null ? null : pageSize,
      orderBy: orderBy,
    );
  }

  /// 模糊查询 // Fuzzy search
  Future<List<dynamic>> blurFind({
    Map<String, Object?>? where,
    Map<String, Object?>? whereMust,
    int? page,
    int pageSize = 20,
    String? orderBy,
    String? groupBy,
  }) async {
    List<String> mustKeys = whereMust?.keys.toList() ?? [];
    List<String> keys = where?.keys.toList() ?? [];
    List<Object?> whereArgs = where?.values.toList() ?? [];
    List<Object?> whereMustArgs = whereMust?.values.toList() ?? [];
    String? sql;
    if (mustKeys.isNotEmpty && keys.isNotEmpty) {
      sql =
          "${mustKeys.join(" = ? AND ")} = ? AND (${keys.join(" LIKE ? OR ")} LIKE ?)";
    } else if (keys.isNotEmpty) {
      sql = "${keys.join(" LIKE ? OR ")} LIKE ?";
    } else if (mustKeys.isNotEmpty) {
      sql = "${mustKeys.join(" = ? AND ")} = ? ";
    }
    return await _db!.query(
      tableName,
      where: sql,
      whereArgs: [...whereMustArgs, ...whereArgs],
      offset: page == null ? null : (page - 1) * pageSize,
      limit: page == null ? null : pageSize,
      orderBy: orderBy,
      groupBy: groupBy,
    );
  }

  /// 原生SQL查询 // Execute raw SQL query
  Future<List<Map<String, Object?>>> rawQuery(String sql) async {
    return _db!.rawQuery(sql);
  }
}
