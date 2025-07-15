// ignore: depend_on_referenced_packages
import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqlite3/sqlite3.dart';

class TeaDatabase {
  static Database? _database;
  static final TeaDatabase instance = TeaDatabase._private();

  TeaDatabase._private();

  Future<Database> _initDatabase() async {
    try {
      final databasePath = join(current, "tea_database.db");
      _database = sqlite3.open(databasePath);

      _createTableIfNotExists();

      log("Success database created");

      return teaDatabase;
    } on Object catch (error, stack) {
      log("Catched error into database execute proccess. Error: $error StackTracer: $stack");
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  Future<Database> get teaDatabase async {
    _database ??= await _initDatabase();

    return _database!;
  }

  Future<void> _createTableIfNotExists() async {
    final result = _database!.select('''SELECT name FROM sqlite_master 
      WHERE type='table' AND name='tea_table'
    ''');

    if (result.isEmpty) {
      _database!.execute('''CREATE TABLE tea_table (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          imagePath TEXT,
          brewingTemperature TEXT,
          gatheringPlace TEXT,
          type TEXT,
          pricePerGram INTEGER,
          age INTEGER,
          countOfSpills INTEGER,
          gatheringYear INTEGER
          )''');
      log('Table with name tea_list has been created');
    } else {
      log('Table with name tea_list is exists');
    }
  }
}
