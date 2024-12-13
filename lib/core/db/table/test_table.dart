import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../db_provider.dart';

class TestTable extends DbProvider {
  // 单例模式
  // Singleton pattern
  TestTable._internal();
  static final TestTable _instance = TestTable._internal();
  factory TestTable() => _instance;

  @override
  String tableName = "test";

  /// Create table in the database
  @override
  Future<void> onCreate(Database db, int version) async {
    debugPrint("Create table");
    // TODO: create table
    await db.execute("""
      CREATE TABLE $tableName (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        indexInt INTEGER,
        image TEXT,
        link TEXT,
        info TEXT,
        type TEXT,
        langType TEXT
      )
    """);
  }

  // TODO: TestEntity
  // ///查询 /// Query function
  // @override
  // Future<List<TestEntity>> find({
  //   Map<String, Object?>? where,
  //   int? page,
  //   int pageSize = 20,
  //   String? orderBy = "indexInt",
  //   String? groupBy,
  // }) async {
  //   List value = await super
  //       .find(where: where, page: page, pageSize: pageSize, orderBy: orderBy);
  //   return fromJson(value);
  // }

  // ///将json转为model
  // /// Convert JSON to model (TestEntity)
  // List<TestEntity> fromJson(List value) {
  //   List<TestEntity> banners = [];
  //   for (var element in value) {
  //     banners.add(TestEntity.fromJson(element));
  //   }
  //   return banners;
  // }
}
