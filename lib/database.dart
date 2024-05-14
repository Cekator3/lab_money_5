// ignore_for_file: curly_braces_in_flow_control_structures, constant_identifier_names

import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// Subsystem for initializing and getting object for interaction with database
class DB
{
  static Database? _db;
  static const _DB_NAME = 'testDb.db';

  static Future<String> _getDatabaseFilepath() async
  {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return path.join(documentsDirectory.path, _DB_NAME);
  }

  static Future<void> _onCreate(Database db, int version) async
  {
    await db.execute(
      '''
      CREATE TABLE categories
      (
          id            INTEGER     PRIMARY KEY AUTOINCREMENT,
          name          TEXT        NOT NULL UNIQUE,
          is_income     INTEGER     NOT NULL CHECK (is_income IN (0, 1)),
          color         INTEGER
      );
      '''
    );

    await db.execute(
      '''
      CREATE TABLE operations
      (
          id              INTEGER     PRIMARY KEY AUTOINCREMENT,
          category_id     INTEGER     NOT NULL,
          date            TEXT        NOT NULL,
          price           REAL        NOT NULL,

          FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
      );
      '''
    );
  }

  static Future<dynamic> _onConfigure(Database db) async
  {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // Initializes and returns object for interaction with database.
  static Future<Database> getInstance() async
  {
    if (_db != null)
      return _db!;

    _db = await openDatabase(
      await _getDatabaseFilepath(),
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure
    );

    return _db!;
  }
}
