import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import '../db_provider.dart';

class TestService extends DbProvider {
  // 单例模式
  static TestService? _instance;
  factory TestService() => _instance ??= TestService._();
  TestService._();

  @override
  String tableName = "test";

  ///创建表
  @override
  Future<void> onCreate(Database db, int version) async {
    debugPrint("创建表");
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
  // ///查询
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
  // List<TestEntity> fromJson(List value) {
  //   List<TestEntity> banners = [];
  //   for (var element in value) {
  //     banners.add(TestEntity.fromJson(element));
  //   }
  //   return banners;
  // }
}
