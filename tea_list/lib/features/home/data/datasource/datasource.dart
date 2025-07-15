import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/shared/data/models/tea_model.dart';

abstract class DataSource {
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type);
}
