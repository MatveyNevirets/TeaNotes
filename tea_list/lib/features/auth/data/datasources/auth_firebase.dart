import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/auth/data/models/user_model.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';

class AuthFirebaseImpl implements AuthRepository {
  @override
  Future<Either<Failure, String>> loginWithEmail(UserModel user) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      final currentUser = userCredential.user;

      if (currentUser != null && !currentUser.emailVerified) {
        return Left(EmailLoginNotVerifedException(null, null));
      }

      return Right("Приятных чаепитий!");
    } on Object catch (error, stack) {
      return Left(EmailLoginException(error, stack));
    }
  }

  @override
  Future<Either<Failure, String>> registerWithEmail({required UserModel user, required VoidCallback onSend}) async {
    final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.email,
      password: user.password,
    );
    try {
      log(user.email + user.password);

      User? newUser = userCredential.user;

      log("currentUser: ${FirebaseAuth.instance.currentUser?.email}");
      log("newUser: ${newUser?.email}");

      if (newUser != null && !newUser.emailVerified) {
        await newUser.sendEmailVerification();

        onSend.call();

        await waitForEmailVerification(newUser);

        return Right("Приятных чаепитий!");
      } else {
        return Right("Auth ???");
      }
    } on Object catch (error, stack) {
      await userCredential.user!.delete();
      return Left(EmailRegistrationException(error, stack));
    }
  }

  Future<void> waitForEmailVerification(User? user) async {
    if (user == null) return;

    FirebaseAuth auth = FirebaseAuth.instance;

    while (!user!.emailVerified) {
      await Future.delayed(Duration(seconds: 3));
      await user.reload();
      user = auth.currentUser;
    }
  }

 
}
