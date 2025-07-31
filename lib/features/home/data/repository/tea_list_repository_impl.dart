import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/home/data/repository/datasource.dart';
import 'package:tea_list/features/home/domain/repository/tea_list_repository.dart';

class TeaListRepositoryImpl implements TeaListRepository {
  final DataSource dataSource;
  TeaListRepositoryImpl(this.dataSource);

  // Overrided method which call datasource and return TeaModel list or Failure
  @override
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type) {
    return dataSource.fetchTeaList(type);
  }

  @override
  Future<Either<Failure, String>> insertTea(TeaModel tea) async {
    try {
      await dataSource.insertTea(tea);
      return Right("Успешно!");
    } on Object catch (error, stack) {
      return Left(DatabaseInsertException(error, stack));
    }
  }
}
