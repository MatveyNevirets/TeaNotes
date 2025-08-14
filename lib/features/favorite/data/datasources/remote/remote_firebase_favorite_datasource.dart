import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/favorite/data/datasources/remote/favorite_datasource.dart';

class RemoteFirebaseFavoriteDatasource implements RemoteFavoriteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  RemoteFirebaseFavoriteDatasource({required this.firestore, required this.firebaseAuth});

  @override
  Future<Either<Failure, List<TeaModel>>> fetchFavoriteTeas() async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        return Left(UserIsNullException("User not authenticated", null));
      }

      final userData = await firestore.collection("users").doc(user.uid).get();

      final userTeasMap = List<Map<String, dynamic>>.from(userData['teas']);

      final userTeas = userTeasMap.map((teaMap) => TeaModel.fromMap(teaMap)).toList();

      final filteredTeas = userTeas.where((tea) => tea.isFavorite).toList();

      return Right(filteredTeas);
    } on Object catch (error, stack) {
      return Left(FetchFavoriteTeaException(error, stack));
    }
  }
}
