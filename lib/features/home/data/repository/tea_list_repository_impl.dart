import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/home/data/datasources/local/home_local_datasource.dart';
import 'package:tea_list/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:tea_list/features/home/domain/repository/tea_list_repository.dart';

class TeaListRepositoryImpl implements TeaListRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;
  final bool isConnection;
  TeaListRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.isConnection});

  // Overrided method which call datasource and return TeaModel list or Failure
  @override
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type, {String? teaName}) {
    return remoteDataSource.fetchTeaList(type, teaName: teaName);
  }

  @override
  Future<Either<Failure, String>> insertTea(TeaModel tea) async {
    try {
      await remoteDataSource.insertTea(tea);
      return Right("Успешно!");
    } on Object catch (error, stack) {
      return Left(DatabaseInsertException(error, stack));
    }
  }

  @override
  Future<Either<Failure, String>> changeTeaFavoriteStatus(bool isFavorite, int index) async {
    try {
      await remoteDataSource.changeFavoriteTeaStatus(isFavorite, index);
      return Right("Успешно!");
    } on Object catch (error, stack) {
      return Left(DatabaseInsertException(error, stack));
    }
  }
}
