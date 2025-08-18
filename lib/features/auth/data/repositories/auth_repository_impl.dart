import 'dart:developer';
import 'dart:ui';

import 'package:dartz/dartz.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tea_list/features/auth/domain/entity/user_entity.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, String>> loginWithEmail(UserEntity user) async {
    try {
      final result = await authRemoteDataSource.loginWithEmail(user);
      return result;
    } on Object catch (error, stack) {
      return Left(EmailLoginException(error, stack));
    }
  }

  @override
  Future<Either<Failure, String>> registerWithEmail({required UserEntity user, required VoidCallback onSend}) async {
    try {
      final result = await authRemoteDataSource.registerWithEmail(user: user, onSend: onSend);
      return result;
    } on Object catch (error, stack) {
      return Left(EmailRegistrationException(error, stack));
    }
  }

  @override
  Future<Either<Failure, String>> signInWithGoogle() async {
    try {
      final result = await authRemoteDataSource.signInWithGoogle();
      return result;
    } on Object catch (error, stack) {
      return Left(GoogleSignInException(error, stack));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> fetchCurrentUser() async {
    try {
      final result = await authRemoteDataSource.fetchCurrentUser();
      late final UserEntity userEntity;

      result.fold(
        (fail) {
          return Left(fail);
        },
        (success) {
          if (success == null) return Right(null);

          userEntity = UserEntity(
            name: success.displayName,
            email: success.email!,
            password: "",
            teas: [],
            ceremonies: [],
          );

          return Right(userEntity);
        },
      );

      return Right(userEntity);
    } on Object catch (error, stack) {
      return Left(FetchUserException(error, stack));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      return await authRemoteDataSource.logout();
    } on Object catch (error, stack) {
      return Left(LogoutException(error, stack));
    }
  }
}
