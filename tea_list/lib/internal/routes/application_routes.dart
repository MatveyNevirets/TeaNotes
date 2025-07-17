import 'package:go_router/go_router.dart';
import 'package:tea_list/features/details/presentation/details_screen.dart';
import 'package:tea_list/features/intro/presentation/intro_screen.dart';
import 'package:tea_list/features/main_page/main_page.dart';
import 'package:tea_list/core/models/tea_model.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(path: "/", builder: (context, state) => IntroScreen()),
    GoRoute(
      path: "/main_page",
      builder: (context, state) => MainPage(),
      routes: [
        GoRoute(
          path: "/details",
          builder: (context, state) {
            final tea = state.extra as TeaModel;
            return DetailsScreen(tea: tea);
          },
        ),
      ],
    ),
  ],
);
