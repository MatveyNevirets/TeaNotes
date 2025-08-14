import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/favorite/data/datasources/remote/favorite_datasource.dart';
import 'package:tea_list/features/favorite/domain/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final RemoteFavoriteDataSource remoteDatasource;
  FavoriteRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Either<Failure, List<TeaModel>>> fetchFavoriteTeas() async {
    return await remoteDatasource.fetchFavoriteTeas();
  }
}
