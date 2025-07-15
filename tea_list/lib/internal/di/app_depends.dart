import 'package:get_it/get_it.dart';
import 'package:tea_list/internal/services/dio_handler.dart';

enum Depends { dio }

typedef OnProccess = Function(String name, int time);
typedef OnError = Function(String name, Object? error, StackTrace? stack);

class AppDepends {
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
  }
}
