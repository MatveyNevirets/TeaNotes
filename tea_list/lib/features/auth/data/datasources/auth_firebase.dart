import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart' hide GoogleSignInException;
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/features/auth/data/models/user_model.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';

class AuthFirebaseImpl implements AuthRepository {
  @override
  Future<Either<Failure, String>> loginWithEmail(UserModel user) async {
    try {
      // Here we create userCredential with firebase
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // Here we fetch user from our firebase credential
      final currentUser = userCredential.user;

      // If user with not verified email we returns exception
      if (currentUser != null && !currentUser.emailVerified) {
        return Left(EmailLoginNotVerifedException(null, null));
      }

      // If well done we go HomeScreen and shows snackbar
      return Right("Приятных чаепитий!");
    } on Object catch (error, stack) {
      return Left(EmailLoginException(error, stack));
    }
  }

  @override
  Future<Either<Failure, String>> registerWithEmail({required UserModel user, required VoidCallback onSend}) async {
    try {
      // Here we try to fetch users from firestore database
      // And check email field
      final doc = await FirebaseFirestore.instance.collection("users").where("email", isEqualTo: user.email).get();

      if (doc.docs.isNotEmpty) {
        // If we see that email have exists
        // We shows snackbar with message to user
        // And returns to RegisterScreen
        return Right("Такой аккаунт уже существует!");
      } else {
        // Here we create user credentials with Firebase
        final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email,
          password: user.password,
        );

        // We try to get user from user credential
        User? newUser = userCredential.user;

        if (newUser != null && !newUser.emailVerified) {
          // If user not null and not verified email
          // We try to send email letter on email
          await newUser.sendEmailVerification();

          // If we sended email without some errors
          // We call VoidCallback that shows snackbar
          onSend.call();

          // Here we calls async method which
          // Wait when user will verificate email
          await waitForEmailVerification(newUser);

          // When user verificated email
          // We insert him user id like doc title
          // And send as map him email and name
          await FirebaseFirestore.instance.collection("users").doc(newUser.uid).set({
            "email": user.email,
            "name": user.name,
          });

          // If all proccessed is OK
          // We go HomeScreen and shows snackbar

          return Right("Приятных чаепитий!");
        } else {
          return Right("Auth ???");
        }
      }
    } on Object catch (error, stack) {
      return Left(EmailRegistrationException(error, stack));
    }
  }

  // This is method called when we wait
  // When user will verificate him email
  Future<void> waitForEmailVerification(User? user) async {
    if (user == null) return;

    // Here we get firebase instance
    final firebaseAuth = GetIt.I<FirebaseAuth>();

    // If user that not null not verificated email
    while (!user!.emailVerified) {
      // We wait every 3 seconds
      await Future.delayed(Duration(seconds: 3));
      // Then reload users state
      await user.reload();
      // And then we get currentUser from firebase auth instance
      user = firebaseAuth.currentUser;
      // Then repeat
    }
  }

  @override
  Future<Either<Failure, String>> signInWithGoogle() async {
    // Here we fech google sign in from GetIt
    final googleSignIn = GetIt.I<GoogleSignIn>();

    try {
      // Here we call google auth screen and wait
      // When user choose account
      GoogleSignInAccount? googleAccount = await googleSignIn.authenticate();

      // Then we give account authentication to give user's token
      final auth = googleAccount.authentication;
      // And create google credential with google auth provider and user's id token
      final googleCredential = GoogleAuthProvider.credential(idToken: auth.idToken);

      // Here we insert google account into firebase authentication
      await FirebaseAuth.instance.signInWithCredential(googleCredential);

      // And then insert into firestore with doc's name like user's id
      // And another user's info like map
      await FirebaseFirestore.instance.collection("users").doc(googleAccount.id).set({
        "name": googleAccount.displayName,
        "email": googleAccount.email,
      });
    } on Object catch (error, stack) {
      return Left(GoogleSignInException(error, stack));
    }

    // If all processes is OK
    // We shows snackbar and go HomeScreen
    return Right("Успешный вход!");
  }
}
