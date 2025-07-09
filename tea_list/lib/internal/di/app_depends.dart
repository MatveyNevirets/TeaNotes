import 'package:get_it/get_it.dart';

enum Depends { zero }

typedef OnProccess = Function(String name, int time);
typedef OnError = Function(String name, Object? error, StackTrace? stack);

class AppDepends {
  final String depend = Depends.values[0].toString();

  Future<void> initDepends({
    required OnProccess onProccess,
    required OnError onError,
  }) async {
    final getIt = GetIt.I;

    try {
      final timer = Stopwatch();
      timer.start();

      Future.delayed(Duration(seconds: 2));

      timer.stop();
      onProccess.call(depend, timer.elapsedMilliseconds);
    } on Object catch (error, stack) {
      onError.call(depend, error, stack);
    }
  }
}
