import 'dart:io';

import 'package:flutter/services.dart';
import 'package:indoxx1/data/indoxx1/datasource/indoxxi_datasource.dart';
import 'package:indoxx1/data/indoxx1/model/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class IndoxxiLocalDatasourceImpl implements IndoxxiDatasource {
  static Database db;

  Future<List> getTables() async {
    if (db == null) {
      return Future.value([]);
    }
    List tables = await db
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    return targetList;
  }

  Future checkTableIsRight() async {
    List<String> expectTables = ['user', 'favorites'];
    List<String> tables = await getTables();

    for (int i = 0; i < expectTables.length; i++) {
      if (!tables.contains(expectTables)) {
        return false;
      }
    }
    return true;
  }

  @override
  Future init({bool isCreate}) async {
    //Get a location using getDatabasesPath
    if (isCreate) {
      String databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'indoxxi.db');
      try {
        db = await openDatabase(path);
      } catch (e) {
        print("Error $e");
      }
      bool tableIsRight = await this.checkTableIsRight();

      if (!tableIsRight) {
        db.close();
        await deleteDatabase(path);
        ByteData data = await rootBundle.load(join("assets", "indoxxi.db"));
        List<int> bytes =
            data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
        await File(path).writeAsBytes(bytes);

        db = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
          print('db created version is $version');
        }, onOpen: (Database db) async {
          print('new db opened');
        });
      } else {
        print('Opening existing database');
      }
    }
  }

  @override
  Future<List<MovieModel>>  listOfPopularMovies(){

  }
}
