import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tea_list/core/consts/tea_models_list.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/home/data/repository/datasource.dart';
import 'package:tea_list/features/home/data/repository/init_datasource_repository.dart';

class LocalDataSource implements DataSource, InitDatasourceRepository {
  late final Database teaDatabase;

  LocalDataSource() {
    initDataSource();
  }

  @override
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type) async {
    try {
      final isFilter = type != null ? true : false;
      final teaMapList =
          isFilter
              ? await teaDatabase.query("tea_table", where: "type = ?", whereArgs: [type])
              : await teaDatabase.query("tea_table");

      final teaList = teaMapList.map((tea) => TeaModel.fromMap(tea)).toList();
      log(teaList.map((e) => e.title).toString());

      return Right(teaList);
    } on Object catch (error, stack) {
      return Left(DatabaseQueryException(error, stack));
    }
  }

  @override
  Future<Either<Failure, String>> insertTea(TeaModel tea) async {
    try {
      await teaDatabase.insert("tea_table", tea.toMap());

      return Right("Success insert tea with title: ${tea.title}");
    } on Object catch (error, stack) {
      return Left(DatabaseInsertException(error, stack));
    }
  }

  @override
  Future<void> initDataSource() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, 'tea_database.db');

      //  deleteDatabase(path);

      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database database, int version) async {
          await database.execute('''CREATE TABLE tea_table (
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

          for (TeaModel tea in teaModelsList) {
            await database.insert("tea_table", tea.toMap());
          }
        },
      );

      log("Local database has been success initilized");

      teaDatabase = database;
    } on Object catch (error, stack) {
      throw Exception("Error on localDatabase initialization. Error: $error StackTrace: $stack");
    }
  }
}
