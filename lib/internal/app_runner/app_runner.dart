import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/internal/app_runner/app_env.dart';
import 'package:tea_list/internal/application/tea_application.dart';
import 'package:tea_list/internal/di/app_depends.dart';
import 'package:tea_list/services/firebase_options.dart';

class AppRunner {
  // App enviroments for application dependencies
  // This is our "switch" between server and without server logic
  final AppEnv appEnv;
  AppRunner(this.appEnv);

  void run() async {
    runZonedGuarded(
      () async {
        _initializeApp();

        // Here we connect with .env file
        await dotenv.load(fileName: ".env");

        // Here we iniailizing Firebase application
        await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

        // Here we initializing all dependencies of this application
        final depends = AppDepends(appEnv);
        await depends.initDepends(
          onProccess: (name, time) => log("Depend $name has been successful initialized in ${time}ms"),
          onError: (name, error, stack) => throw Exception("Error in depend $name Error: $error StackTrace: $stack"),
        );

        // Here we wait when all dependencies will be all ready
        await GetIt.I.allReady();

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
