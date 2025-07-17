import 'package:get_it/get_it.dart';
import 'package:tea_list/features/home/data/datasources/remote_source.dart';
import 'package:tea_list/features/home/data/repository/datasource.dart';
import 'package:tea_list/internal/app_runner/app_env.dart';
import 'package:tea_list/internal/services/dio_handler.dart';

enum Depends { dio, sqliteDatabase }

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

      // Here we register DioHandler into getIt with lazySingleton
      getIt.registerLazySingleton(() => DioHandler());

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

      dataSource = switch (appEnv) {
        AppEnv.serverProd => RemoteDataSource(),
        AppEnv.withoutServerProd => RemoteDataSource(), //TODO: MUST CHANGE LATER
      };
        
        return dataSource;
      });

      timer.stop();
      // Reports about successful registration of depend
      onProccess.call(Depends.values[1].name, timer.elapsedMilliseconds);
    } on Object catch (error, stack) {
      // Reports about failure
      onError.call(Depends.values[1].name, error, stack);
    }
  }
}
