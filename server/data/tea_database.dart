// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

late Database database;

class TeaDatabase {
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "tea_database.db");

    try {
      return await openDatabase(
        path,
        onCreate: (Database db, int version) {
            db.execute('''CREATE TABLE tea_table (
          id INTEGER AUTOINCREMENT PRIMARY KEY,
          title TEXT,
          description TEXT,
          pricePerGram INTEGER,
          )''');
        },
      );
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }

  Future<void> startDatabase() async {
    database = await _initDatabase();
  }
}
