import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';

abstract class RemoteFavoriteDataSource {
  Future<Either<Failure, List<TeaModel>>> fetchFavoriteTeas();
}