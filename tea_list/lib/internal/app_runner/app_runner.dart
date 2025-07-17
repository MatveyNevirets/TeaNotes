import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tea_list/internal/app_runner/app_env.dart';
import 'package:tea_list/internal/application/tea_application.dart';
import 'package:tea_list/internal/di/app_depends.dart';

class AppRunner {
  // App enviroments for application dependencies
  // This is our "switch" between server and without server logic
  final AppEnv appEnv;
  AppRunner(this.appEnv);

  void run() async {
    runZonedGuarded(
      () async {
        _initializeApp();

        // Here we initializing all dependencies of this application
        final depends = AppDepends(appEnv);
        await depends.initDepends(
          onProccess: (name, time) => log("Depend $name has been successful initialized in ${time}ms"),
          onError: (name, error, stack) => throw Exception("Error in depend $name Error: $error StackTrace: $stack"),
        );

        // Here we runs our application
        runApp(TeaApplication());

        // Here we unfreeze first frame and activates our application
        WidgetsBinding.instance.addPostFrameCallback((_) {
          WidgetsBinding.instance.allowFirstFrame();
        });
      },
      (error, stack) {
        throw Exception("Error in AppRunner $error StackTrace $stack");
      },
    );
  }

  void _initializeApp() {
    WidgetsFlutterBinding.ensureInitialized();
    WidgetsBinding.instance.deferFirstFrame();
  }
}
