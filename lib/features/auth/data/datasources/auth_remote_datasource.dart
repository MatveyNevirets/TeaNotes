import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/auth/domain/entity/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<Either<Failure, String>> registerWithEmail({required UserEntity user, required VoidCallback onSend});
  Future<Either<Failure, String>> loginWithEmail(UserEntity user);
  Future<Either<Failure, String>> signInWithGoogle();
}
