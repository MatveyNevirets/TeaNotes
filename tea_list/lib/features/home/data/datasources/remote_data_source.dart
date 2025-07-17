import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/home/data/repository/datasource.dart';
import 'package:tea_list/internal/services/dio_handler.dart';

class RemoteDataSource implements DataSource {
  final _getIt = GetIt.I;

  @override
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type) async {
    final dio = _getIt<DioHandler>().dio;

    try {
      // Here we create a response which depends of our type. If we have type
      // We calls GET request with type. If we havn't any type we calls GET request with the teas
      // Without some specific type
      final response = type != null ? await dio.get("/teas?type=$type") : await dio.get("/teas");

      if (response.statusCode == 200) {
        // Here we get the data with specific type "List<dynamic>"
        // That we are doing because we wanna use .map method from List
        final data = response.data as List<dynamic>;

        // Here we go through elements from data and then transform
        // Every element to TeaModel object
        final teas = data.map((element) => TeaModel.fromMap(element)).toList();

        // Return List<TeaModel> type. Success
        return Right(teas);
      } else {
        // We have some server error. Return failure
        log("Error in remote data source. Response code: ${response.statusCode}");
        return Left(ServerException(null, null));
      }
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
}
