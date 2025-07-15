import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/home/data/datasource/datasource.dart';
import 'package:tea_list/internal/services/dio_handler.dart';
import 'package:tea_list/shared/data/models/tea_model.dart';

class RemoteDataSource implements DataSource {
  final _getIt = GetIt.I;

  @override
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type) async {
    final dio = _getIt<DioHandler>().dio;

    try {
      final response = type != null ?  await dio.get("/teas?type=$type") :  await dio.get("/teas");
      
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        final teas = data.map((element) => TeaModel.fromMap(element)).toList();

        for (var tea in teas) {
          log("tea title: ${tea.title}");
        }

        return Right(teas);
      } else {
        return Left(ServerException());
      }
    } on Object catch (error, stack) {
      log("Error: ${error.toString()} StackTrace: $stack");
      return Left(ServerException());
    }
  }
}
