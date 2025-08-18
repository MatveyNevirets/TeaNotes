import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart' hide GoogleSignInException;
import 'package:tea_list/core/errors/errors.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tea_list/features/auth/data/models/user_model.dart';

class FirebaseAuthRemoteDatasource implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;
  final GoogleSignIn googleSignIn;

  FirebaseAuthRemoteDatasource({
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.googleSignIn,
  });

  @override
  Future<Either<Failure, String>> loginWithEmail(UserModel user) async {
    try {
      // Here we create userCredential with firebase
      final userCredential = await firebaseAuth.signInWithEmailAndPassword(email: user.email, password: user.password);

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
      final doc = await firebaseFirestore.collection("users").where("email", isEqualTo: user.email).get();

      if (doc.docs.isNotEmpty) {
        // If we see that email have exists
        // We shows snackbar with message to user
        // And returns to RegisterScreen
        return Right("Такой аккаунт уже существует!");
      } else {
        // Here we create user credentials with Firebase
        final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
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

          // Here we get all default_teas from firestore
          final defaultTeasQuery = await firebaseFirestore.collection("default_teas").get();

          // Here we create List<Map<String, dynamic>> list
          final defaultTeas = defaultTeasQuery.docs.map((doc) => doc.data()).toList();

          // Here we add to new user all defaults tea
          user.teas = defaultTeas.map((teaMap) => TeaModel.fromMap(teaMap)).toList();

          // Here we transform user to map
          Map<String, dynamic> userMap = user.toMap();

          // When user verificated email
          // We insert him user id like doc title
          // And send as map him email and name
          await firebaseFirestore.collection("users").doc(newUser.uid).set(userMap);

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
    try {
      // Here we call google auth screen and wait
      // When user choose account
      GoogleSignInAccount? googleAccount = await googleSignIn.authenticate();

      // Then we give account authentication to give user's token
      final auth = googleAccount.authentication;
      // And create google credential with google auth provider and user's id token
      final googleCredential = GoogleAuthProvider.credential(idToken: auth.idToken);

      // Here we insert google account into firebase authentication
      // userFirebase need to fetch normal uid parameter to
      // Fetch user's data later
      final userFirebase = await firebaseAuth.signInWithCredential(googleCredential);

      final userIntoFirestore = await firebaseFirestore.collection("users").doc(userFirebase.user!.uid).get();

      if (!userIntoFirestore.exists) {
        // Here we create user model to trasform that one to map
        final user = UserModel(
          email: googleAccount.email,
          password: "google",
          name: googleAccount.displayName,
          teas: [],
          ceremonies: [],
        );

        // Here we get all default_teas from firestore
        final defaultTeasQuery = await firebaseFirestore.collection("default_teas").get();

        // Here we create List<Map<String, dynamic>> list
        final defaultTeas = defaultTeasQuery.docs.map((doc) => doc.data()).toList();

        // Here we add to new user all defaults tea
        user.teas = defaultTeas.map((teaMap) => TeaModel.fromMap(teaMap)).toList();

        // Here we transform user to map
        Map<String, dynamic> userMap = user.toMap();

        // And then insert into firestore with doc's name like user's id
        // And another user's info like map
        await firebaseFirestore.collection("users").doc(userFirebase.user!.uid).set(userMap);
      }
    } on Object catch (error, stack) {
      return Left(GoogleSignInException(error, stack));
    }

    // If all processes is OK
    // We shows snackbar and go HomeScreen
    return Right("Успешный вход!");
  }

  @override
  Future<Either<Failure, User?>> fetchCurrentUser() async {
    try {
      // Here we just fetch and then returns user
      final user = firebaseAuth.currentUser;
      return Right(user);
    } on Object catch (error, stack) {
      return Left(FetchUserException(error, stack));
    }
  }

  @override
  Future<Either<Failure, String>> logout() async {
    try {
      // Here we fetch user
      final user = firebaseAuth.currentUser;

      // Then check that user not null
      if (user == null) return Left(LogoutException(null, null));

      // If all good we sign out
      await firebaseAuth.signOut();

      // And returns success message
      return Right("Успех!");
    } on Object catch (error, stack) {
      return Left(LogoutException(error, stack));
    }
  }
}
