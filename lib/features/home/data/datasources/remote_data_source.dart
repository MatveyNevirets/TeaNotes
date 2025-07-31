import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/auth/data/models/user_model.dart';
import 'package:tea_list/features/home/data/repository/datasource.dart';

class FirebaseRemoteDataSource implements DataSource {
  final FirebaseFirestore instance = FirebaseFirestore.instance;
  final auth = GetIt.I<FirebaseAuth>();

  @override
  Future<Either<Failure, List<TeaModel>>> fetchTeaList(String? type, {String? teaName}) async {
    try {
      // Here we fetch user id
      final uid = auth.currentUser!.uid;

      // Here we fetch user snapshot to transform that one to map
      final userSnapshot = await instance.collection("users").doc(uid).get();

      // Here we transform snapshot to map
      final userData = userSnapshot.data()!;

      // Here we fetch user model
      final user = UserModel.fromMap(userData);

      log(type.toString());
      log(teaName.toString());

      // This is filtered teas. If type is null we give all teas else teas with need type
      final filteredTeas =
          teaName ==
                  null // If teaName is null
              ? type ==
                      null // We check type
                  ? user
                      .teas // If type is null we shows all teas
                  // If type not null we shows teas by current type
                  : user.teas.where((tea) => tea.type == type).toList()
              // Else if teaName not null we search by name
              : user.teas.where((tea) => tea.title.toLowerCase().contains(teaName.toLowerCase())).toList();

      // Here we returns to user's screen all teas from account
      return Right(filteredTeas);
    } on Object catch (error, stack) {
      // Here we have some errors in our try-catch block.
      // Calls Failure too
      return Left(ServerException(error, stack));
    }
  }

  @override
  Future<Either<Failure, String>> insertTea(TeaModel tea) async {
    // Here we get user's id
    final uid = auth.currentUser!.uid;

    // Here we insert new tea into database
    await instance.collection("users").doc(uid).update({
      "teas": FieldValue.arrayUnion([tea.toMap()]),
    });

    return Right("Успешно!");
  }
}
