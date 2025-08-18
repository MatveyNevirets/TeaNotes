import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/runtime_ceremony/data/datasources/remote/remote_datasource.dart';
import 'package:tea_list/core/models/ceremony_model.dart';

class RemoteFirebaseDatasource implements RemoteDatasource {
  @override
  Future<Either<Failure, String>> tryFinishCeremony(CeremonyModel ceremony) async {
    final auth = FirebaseAuth.instance;
    final instance = FirebaseFirestore.instance;

    final user = auth.currentUser;

    await instance.collection("users").doc(user!.uid).update({
      "ceremonies": FieldValue.arrayUnion([ceremony.toMap()]),
    });

    return Right("Success");
  }
}
