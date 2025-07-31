import 'package:tea_list/internal/app_runner/app_env.dart';
import 'package:tea_list/internal/app_runner/app_runner.dart';

void main() {
  AppRunner(AppEnv.prod).run();
}
