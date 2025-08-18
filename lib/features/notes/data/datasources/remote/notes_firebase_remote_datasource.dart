import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/ceremony_model.dart';
import 'package:tea_list/features/auth/data/models/user_model.dart';
import 'package:tea_list/features/notes/data/datasources/remote/notes_remote_datasource.dart';

class NotesFirebaseRemoteDatasource implements NotesRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;

  NotesFirebaseRemoteDatasource({required this.firestore, required this.firebaseAuth});

  @override
  Future<Either<Failure, List<CeremonyModel>>> fetchUsersNotes() async {
    try {
      final user = firebaseAuth.currentUser;

      if (user == null) {
        return Left(UserIsNullException(null, null));
      }

      final docs = await firestore.collection("users").doc(user.uid).get();

      final userModel = UserModel.fromMap(docs.data()!);

      return Right(userModel.ceremonies);
    } on Object catch (error, stack) {
      return Left(FetchNotesException(error, stack));
    }
  }
}
