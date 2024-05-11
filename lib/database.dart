import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

// Subsystem for initializing and getting object for interaction with database
class DB
{
  // Initializes and returns object for interaction with database.
  static Future<Database> getInstance() async
  {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version)
      {
        return db.execute('''
          CREATE TABLE categories
          (
              id          INTEGER     PRIMARY KEY,
              name        TEXT        NOT NULL,
              isIncome    INTEGER     NOT NULL CHECK (isIncome IN (0, 1)),
              color       INTEGER
          );

          CREATE TABLE operations
          (
              id              INTEGER     PRIMARY KEY,
              category_id     INTEGER     NOT NULL,
              date            INTEGER     NOT NULL,
              price           REAL        NOT NULL
          );
        ''');
      }
    );
  }
}
