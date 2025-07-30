import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/home/data/repository/datasource.dart';

class RemoteDataSource implements DataSource {
  final _getIt = GetIt.I;

  @override
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type) async {
    try {
      

      return Right([]);
    } on Object catch (error, stack) {
      // Here we have some errors in our try-catch block.
      // Calls Failure too
      return Left(ServerException(error, stack));
    }
  }

  @override
  Future<Either<Failure, String>> insertTea(TeaModel tea) {
    // TODO: implement insertTea
    throw UnimplementedError();
  }

  @override
  Future<void> initDataSource() {
    // TODO: implement initDataSource
    throw UnimplementedError();
  }
}
