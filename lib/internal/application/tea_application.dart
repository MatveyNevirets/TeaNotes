import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/internal/routes/application_routes.dart';

class TeaApplication extends StatelessWidget {
  const TeaApplication({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.black.withAlpha(190);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.applicationBackroundColor,
        iconTheme: IconThemeData(color: Colors.white),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColors.applicationBaseColor,
          selectionColor: Colors.transparent,
          selectionHandleColor: AppColors.selectedItemColor,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            fontSize: 30,
            fontFamily: 'Coiny',
            fontWeight: FontWeight.w400,
            height: 0.9,
            color: textColor,
          ),
          bodyMedium: TextStyle(fontSize: 24, fontFamily: 'Coiny', height: 0.9, color: textColor),
          bodySmall: TextStyle(fontSize: 14, fontFamily: 'Coiny', height: 0.9, color: textColor),
        ),
      ),
    );
  }
}
