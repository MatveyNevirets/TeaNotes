import 'package:flutter/material.dart';
import 'package:tea_list/internal/routes/application_routes.dart';

class TeaApplication extends StatelessWidget {
  const TeaApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(fontSize: 30, fontFamily: 'Coiny', fontWeight: FontWeight.w400),
          bodyMedium: TextStyle(fontSize: 24, fontFamily: 'Coiny'),
          bodySmall: TextStyle(fontSize: 14, fontFamily: 'Coiny'),
        ),
      ),
    );
  }
}
