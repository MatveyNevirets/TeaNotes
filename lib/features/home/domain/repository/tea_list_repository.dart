import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';

abstract class TeaListRepository {
  // Domain repository which connected with data and presentation layers
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type, {String? teaName});
  Future<Either<Failure, String>> insertTea(TeaModel tea);
  Future<Either<Failure, String>> changeTeaFavoriteStatus(bool isFavorite, int index);
}
