import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:tea_list/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:tea_list/features/auth/data/datasources/firebase_auth_remote_datasource.dart';
import 'package:tea_list/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';
import 'package:tea_list/features/favorite/data/datasources/remote/favorite_datasource.dart';
import 'package:tea_list/features/favorite/data/datasources/remote/remote_firebase_favorite_datasource.dart';
import 'package:tea_list/features/favorite/data/repository/favorite_repository_impl.dart';
import 'package:tea_list/features/favorite/domain/favorite_repository.dart';
import 'package:tea_list/features/home/data/datasources/local/home_local_datasource.dart';
import 'package:tea_list/features/home/data/datasources/local/home_sqlflite_local_datasource.dart';
import 'package:tea_list/features/home/data/datasources/remote/home_firebase_remote_data_source.dart';
import 'package:tea_list/features/home/data/datasources/remote/home_remote_datasource.dart';
import 'package:tea_list/features/home/data/repository/tea_list_repository_impl.dart';
import 'package:tea_list/features/home/domain/repository/tea_list_repository.dart';
import 'package:tea_list/features/notes/data/datasources/remote/notes_firebase_remote_datasource.dart';
import 'package:tea_list/features/notes/data/datasources/remote/notes_remote_datasource.dart';
import 'package:tea_list/features/notes/data/repository/notes_repository_impl.dart';
import 'package:tea_list/features/notes/domain/repository/notes_repository.dart';
import 'package:tea_list/features/tea_posts/data/datasources/remote/posts_firebase_remote_datasource.dart';
import 'package:tea_list/features/tea_posts/data/datasources/remote/posts_remote_datasource.dart';
import 'package:tea_list/features/tea_posts/data/repository/tea_posts_repository_impl.dart';
import 'package:tea_list/features/tea_posts/domain/repository/tea_posts_repository.dart';
import 'package:tea_list/internal/app_runner/app_env.dart';

enum Depends {
  firebaseAuth,
  firebaseFirestore,
  googleSignIn,
  authRemoteDataSource,
  authRepository,
  homeRemoteDataSource,
  homeLocalDataSource,
  teaListRepository,
  teaPostsRemoteDataSource,
  teaPostsRepository,
  favoriteRemoteDataSource,
  favoriteRepository,
  notesRemoteDatasource,
  notesRepository,
}

typedef OnProccess = Function(String name, int time);
typedef OnError = Function(String name, Object? error, StackTrace? stack);

class AppDepends {
  // We get this from AppRunner for use in switch between server and without server
  // Application logic
  final AppEnv appEnv;
  AppDepends(this.appEnv);

  Future<void> initDepends({required OnProccess onProccess, required OnError onError}) async {
    final getIt = GetIt.I;
    final connection = await InternetConnection().hasInternetAccess;
    if (connection) {
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register firebase auth and initialize Firebase application
        getIt.registerLazySingleton(() {
          late final FirebaseAuth firebaseAuth;

          // Here we fetch firebase auth instance

          firebaseAuth = FirebaseAuth.instance;

          return firebaseAuth;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[0].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[0].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's database into getIt with lazySingleton
        getIt.registerLazySingleton(() {
          late final FirebaseFirestore firebaseFirestore;

          // Here we fetch firebase firestore instance
          firebaseFirestore = FirebaseFirestore.instance;

          return firebaseFirestore;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[1].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[1].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's database into getIt with lazySingleton
        getIt.registerSingletonAsync<GoogleSignIn>(() async {
          late final GoogleSignIn googleSignIn;

          // Here we fetch GoogleSignIn instance
          googleSignIn = GoogleSignIn.instance;
          // And then initialize this one from firebase's client id
          await googleSignIn.initialize(serverClientId: dotenv.env['CLIENT_ID']);

          return googleSignIn;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[2].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[2].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        getIt.registerSingletonAsync<AuthRemoteDataSource>(() async {
          late final AuthRemoteDataSource authRemoteDataSource;

          // And fetch our auth repository implementation
          authRemoteDataSource = FirebaseAuthRemoteDatasource(
            firebaseAuth: getIt<FirebaseAuth>(),
            firebaseFirestore: getIt<FirebaseFirestore>(),
            googleSignIn: getIt<GoogleSignIn>(),
          );

          return authRemoteDataSource;
        }, dependsOn: [GoogleSignIn]);

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[3].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[3].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's tea posts repository
        // Into getIt with lazySingleton
        getIt.registerLazySingleton(() {
          late final HomeRemoteDataSource homeRemoteDataSource;

          // Here we setup repository's implementation
          homeRemoteDataSource = HomeFirebaseRemoteDataSource();

          return homeRemoteDataSource;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[5].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[5].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's tea posts repository
        // Into getIt with lazySingleton
        getIt.registerLazySingleton(() {
          late final HomeLocalDataSource homeLocalDataSource;

          // Here we setup repository's implementation
          homeLocalDataSource = HomeSqfliteLocalDataSource();

          return homeLocalDataSource;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[6].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[6].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's tea posts repository
        // Into getIt with lazySingleton
        getIt.registerLazySingleton(() {
          late final TeaListRepository teaListRepository;

          // Here we setup repository's implementation
          teaListRepository = TeaListRepositoryImpl(
            remoteDataSource: getIt<HomeRemoteDataSource>(),
            localDataSource: getIt<HomeLocalDataSource>(),
            isConnection: true,
          );

          return teaListRepository;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[7].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[7].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        getIt.registerSingletonAsync<AuthRepository>(() async {
          late final AuthRepository authRepository;

          // And fetch our auth repository implementation

          authRepository = AuthRepositoryImpl(authRemoteDataSource: getIt<AuthRemoteDataSource>());

          return authRepository;
        }, dependsOn: [AuthRemoteDataSource]);

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[4].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[4].name, error, stack);
      }

      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's tea posts remote datasource
        // Into getIt with lazySingleton
        getIt.registerLazySingleton(() {
          late final PostsRemoteDatasource postsRemoteDataSource;

          // Here we setup repository's implementation
          postsRemoteDataSource = PostsFirebaseRemoteDatasource(firestore: getIt<FirebaseFirestore>());

          return postsRemoteDataSource;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[8].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[8].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's tea posts repository
        // Into getIt with lazySingleton
        getIt.registerLazySingleton(() {
          late final TeaPostsRepository teaPostsRepository;

          // Here we setup repository's implementation
          teaPostsRepository = TeaPostsRepositoryImpl(postsRemoteDatasource: getIt<PostsRemoteDatasource>());

          return teaPostsRepository;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[9].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[9].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's remote favorite datasource
        // Into getIt with lazySingleton
        getIt.registerLazySingleton(() {
          late final RemoteFavoriteDataSource remoteFavoriteDataSource;

          // Here we setup datasource's implementation
          remoteFavoriteDataSource = RemoteFirebaseFavoriteDatasource(
            firebaseAuth: getIt<FirebaseAuth>(),
            firestore: getIt<FirebaseFirestore>(),
          );

          return remoteFavoriteDataSource;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[10].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[10].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's favorite repository
        // Into getIt with lazySingleton
        getIt.registerLazySingleton(() {
          late final FavoriteRepository favoriteRepository;

          // Here we setup repository's implementation
          favoriteRepository = FavoriteRepositoryImpl(remoteDatasource: getIt<RemoteFavoriteDataSource>());

          return favoriteRepository;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[9].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[9].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's notes remote datasource
        // Into getIt with lazySingleton
        getIt.registerLazySingleton(() {
          late final NotesRemoteDatasource notesRemoteDatasource;

          // Here we setup datasource's implementation
          notesRemoteDatasource = NotesFirebaseRemoteDatasource(
            firestore: getIt<FirebaseFirestore>(),
            firebaseAuth: getIt<FirebaseAuth>(),
          );

          return notesRemoteDatasource;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[10].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[10].name, error, stack);
      }
      try {
        final timer = Stopwatch();
        timer.start();

        // Here we register application's favorite repository
        // Into getIt with lazySingleton
        getIt.registerLazySingleton(() {
          late final NotesRepository notesRepository;

          // Here we setup repository's implementation
          notesRepository = NotesRepositoryImpl(notesRemoteDatasource: getIt<NotesRemoteDatasource>());

          return notesRepository;
        });

        timer.stop();
        // Reports about successful registration of depend
        onProccess.call(Depends.values[11].name, timer.elapsedMilliseconds);
      } on Object catch (error, stack) {
        // Reports about failure
        onError.call(Depends.values[11].name, error, stack);
      }
    }
  }
}
