import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';

abstract class GoogleAuthRepository {
  Future<Either<Failure, String>> signInWithGoogle();
}