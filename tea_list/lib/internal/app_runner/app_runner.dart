import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tea_list/internal/application/tea_application.dart';
import 'package:tea_list/internal/di/app_depends.dart';

class AppRunner {
  void run() async {
    runZonedGuarded(
      () async {
        _initializeApp();

        final depends = AppDepends();
        await depends.initDepends(
          onProccess:
              (name, time) => log(
                "Depend $name has been successful initialized in ${time}ms",
              ),
          onError:
              (name, error, stack) =>
                  throw Exception(
                    "Error in depend $name Error: $error StackTreace: $stack",
                  ),
        );

        runApp(TeaApplication());

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
