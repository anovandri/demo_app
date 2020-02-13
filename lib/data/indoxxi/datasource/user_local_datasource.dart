import 'package:flutter/services.dart';
import 'package:indoxx1/data/indoxxi/datasource/user_datasource.dart';
import 'package:indoxx1/data/indoxxi/model/user.dart';
import 'package:path/path.dart';

import 'package:sqflite/sqflite.dart';
import 'dart:io';

class UserLocalDatasourceImpl implements UserDatasource {

  final String ERROR_TOKEN_ALREADY_EXISTS = "Token is already exists";
  final String SUCCESS = "Success";
  
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
  Future<UserModel> getUser({String tokenId}) async {
    List<Map<String, dynamic>> users = await db.rawQuery('SELECT token_id, name, email FROM user WHERE token_id = "$tokenId"');
    Map<String, dynamic> user = !users.isEmpty ? users.first : null;
    return user != null ? UserModel.userFromJson(user) : null;
  }

  @override
  Future<String> addNewUser({String name, String email, String tokenId}) async {
    UserModel model = await this.getUser(tokenId: tokenId);
    if (model != null && model.tokenId != '') {
      return ERROR_TOKEN_ALREADY_EXISTS;
    }
    try {
      await db.rawQuery('INSERT INTO user (token_id, name, email) VALUES ("$tokenId", "$name", "$email")');
    } catch (error) {
      return error;
    }
    return SUCCESS;
  }
}