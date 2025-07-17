import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';

// DataSource interface which will can help with
// Different datasources like remote or local.
// Or choose another database like SQLite and PostgreSQL
abstract class DataSource {
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type);
}
