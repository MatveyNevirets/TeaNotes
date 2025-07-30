import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tea_list/features/auth/data/datasources/auth_firebase.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';
import 'package:tea_list/features/home/data/datasources/remote_data_source.dart';
import 'package:tea_list/features/home/data/repository/datasource.dart';
import 'package:tea_list/internal/app_runner/app_env.dart';
import 'package:tea_list/services/firebase_options.dart';

enum Depends { firebase, sqliteDatabase, googleSignIn, auth }

typedef OnProccess = Function(String name, int time);
typedef OnError = Function(String name, Object? error, StackTrace? stack);

class AppDepends {
  // We get this from AppRunner for use in switch between server and without server
  // Application logic
  final AppEnv appEnv;
  AppDepends(this.appEnv);

  Future<void> initDepends({required OnProccess onProccess, required OnError onError}) async {
    final getIt = GetIt.I;

    try {
      final timer = Stopwatch();
      timer.start();

      getIt.registerSingletonAsync<AuthRepository>(() async {
        late final AuthRepository authRepository;

        // Here we initialize all Firebase options
        await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

        // And fetch our auth repository implementation
        authRepository = AuthFirebaseImpl();

        return authRepository;
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
        late final DataSource dataSource;
        // Here we fetch our datasource implementation
        dataSource = FirebaseRemoteDataSource();

        return dataSource;
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

      // Here we register application's database into getIt with lazySingleton
      getIt.registerLazySingleton(() {
        late final FirebaseAuth firebaseAuth;

        // Here we fetch firebase auth instance
        firebaseAuth = FirebaseAuth.instance;

        return firebaseAuth;
      });

      timer.stop();
      // Reports about successful registration of depend
      onProccess.call(Depends.values[3].name, timer.elapsedMilliseconds);
    } on Object catch (error, stack) {
      // Reports about failure
      onError.call(Depends.values[3].name, error, stack);
    }
  }
}
