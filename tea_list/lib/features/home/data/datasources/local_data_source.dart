import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/home/data/repository/datasource.dart';

class LocalDataSource implements DataSource {
  late final Database teaDatabase;

  LocalDataSource() {
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    try {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, 'tea_database.db');

      Database database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database database, int version) async {
          database.transaction((txn) async {
            await txn.execute('''CREATE TABLE tea_table (
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

            final tea2 = TeaModel(
              title: "Гунтин Зелёное Дерево",
              description: '''Премиальный зрелый гунтин из отборного сырья.
Слово Гунтин (кит. 宫廷, «Дворцовый») указывает на категорию сырья, т.е. размер листа. Такие листья мелкие, и при этом цельные, а не резанные. В гунтинах нежные листочки обязательно перемежаются большим количеством чайных почек. Вместе они обеспечивают сильный вкус и мощное воздействие.

Аромат
Сладковатый, с нотами древесины и орехов.

Вкус
Густой, бархатистый, плотный и мягкий, с доминирующей шоколадно-ореховой тематикой. Послевкусие обволакивающее, сладкое, продолжительное.

Воздействие
Хорошо тонизирует, согревает, воодушевляет.''',
              imagePath: "assets/images/green_tree.jpg",
              pricePerGram: 12,
              age: 8,
              type: "Шу Пуэр",
              brewingTemperature: "95-85С",
              countOfSpills: 6,
              gatheringYear: 2017,
              gatheringPlace:
                  "Фабрика Баньчжан в уезде Мэнхай (кит. 勐海縣班章), горы Буланшань, уезд Мэнхай, округ Сишуанбаньна, провинция Юньнань, Китай.",
            );

            final tea1 = TeaModel(
              title: "Золотой бык",
              description:
                  '''Мощный и яркий молодой шэн пуэр с интересным профилем и хорошим балансом от известной чайной фабрики Син Вэнь. Хорошо сбалансирован для молодого шэна.

Аромат
Медово-копчёный, цветочный. Пьянящий, сладкий аромат из пустой горячий пиалы.

Вкус
Мягкий, ровный, сладко-сухофруктовый, с нотками цветов, чернослива, кураги и слегка пропечёной травы. Очень приятное, объёмное послевкусие, тёплое и уютное.

Воздействие
Мощное, тонизирующее, освежающее.''',
              imagePath: "assets/images/golden_bull.jpg",
              pricePerGram: 16,
              age: 4,
              type: "Шен Пуэр",
              brewingTemperature: "95-85C",
              countOfSpills: 10,
              gatheringYear: 2021,
              gatheringPlace: "Фабрика Синь Вэнь, уезд Юндэ, округ Линьцан, провинция Юньнань, Китай.",
            ); //TODO: MUST CLEAR THIS SHIT

            await txn.insert("tea_table", tea1.toMap());
            await txn.insert("tea_table", tea2.toMap());
          });
        },
      );

      log("Local database has been success initilized");

      teaDatabase = database;
    } on Object catch (error, stack) {
      throw Exception("Error on localDatabase initialization. Error: $error StackTrace: $stack");
    }
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
}
