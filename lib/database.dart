import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

// Subsystem for initializing and getting object for interaction with database
class DB
{
  static const _DB_NAME = 'testDb.db';

  static Future<String> _getDatabaseFilepath() async
  {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return path.join(documentsDirectory.path, _DB_NAME);
  }

  static Future<void> _onCreate(Database db, int version) async
  {
    return await db.execute('''
      CREATE TABLE categories
      (
          id          INTEGER     PRIMARY KEY,
          name        TEXT        NOT NULL UNIQUE,
          isIncome    INTEGER     NOT NULL CHECK (isIncome IN (0, 1)),
          color       INTEGER
      );

      CREATE TABLE operations
      (
          id              INTEGER     PRIMARY KEY,
          category_id     INTEGER     NOT NULL,
          date            INTEGER     NOT NULL,
          price           REAL        NOT NULL,

          FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE CASCADE
      );
    ''');
  }

  static Future<dynamic> _onConfigure(Database db) async
  {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // Initializes and returns object for interaction with database.
  static Future<Database> getInstance() async
  {
    await databaseFactory.deleteDatabase(await _getDatabaseFilepath());
    return await openDatabase(
      await _getDatabaseFilepath(),
      version: 3,
      onCreate: _onCreate,
      onConfigure: _onConfigure
    );
  }
}
