import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/home/data/datasource/datasource.dart';
import 'package:tea_list/features/home/domain/repository/tea_list_repository.dart';
import 'package:tea_list/shared/data/models/tea_model.dart';

class TeaListRepositoryImpl implements TeaListRepository {
  final DataSource dataSource;
  TeaListRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type)  {
    return dataSource.fetchTeaList(type);
  }
}
