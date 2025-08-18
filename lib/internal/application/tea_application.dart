import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';
import 'package:tea_list/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tea_list/internal/routes/application_routes.dart';

class TeaApplication extends StatelessWidget {
  const TeaApplication({super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = Colors.black.withAlpha(190);

    final authRepository = GetIt.I<AuthRepository>();
    return BlocProvider(
      create: (context) => AuthBloc(authRepository)..add(CheckUserLoginEvent()),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.applicationBackroundColor,
          iconTheme: IconThemeData(color: Colors.white),
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: const Color.fromARGB(255, 129, 125, 120),
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
      ),
    );
  }
}
