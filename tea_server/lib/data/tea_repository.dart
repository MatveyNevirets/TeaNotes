import 'package:server/data/models/tea_model.dart';
import 'package:sqlite3/sqlite3.dart';

class TeaRepository {
  final Database database;

  TeaRepository(this.database);

  void addTea(Tea tea) {
    final trx = database.prepare('''
  INSERT INTO tea_table (title, description, brewingTemperature, gatheringPlace,
  type, pricePerGram, age, countOfSpills, gatheringYear)
  VALUES (?,?,?,?,?,?,?,?,?)
''');

    trx.execute([
      tea.title,
      tea.description,
      tea.brewingTemperature,
      tea.gatheringPlace,
      tea.type,
      tea.pricePerGram,
      tea.age,
      tea.countOfSpills,
      tea.gatheringYear,
    ]);
    trx.dispose();

    print("Success added ${tea.title}");
  }

  Future<List<Tea>> getTeas(String? type) async {
    final bool withFilter = type != null;

    final sql = withFilter ? 'SELECT * FROM tea_table WHERE type = ?' : 'SELECT * FROM tea_table';

    final stmt = database.prepare(sql);

    final result = withFilter ? stmt.select([type]) : stmt.select();

    final teas = result.map(Tea.fromRow).toList();

    stmt.dispose();

    return teas;
  }
}
