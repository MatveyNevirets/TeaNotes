import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/auth/presentation/login/login_page.dart';
import 'package:tea_list/features/auth/presentation/registration/registration_page.dart';
import 'package:tea_list/features/auth/presentation/welcome/welcome_page.dart';
import 'package:tea_list/features/details/presentation/details_page.dart';
import 'package:tea_list/features/main_page/main_page.dart';
import 'package:tea_list/features/tea_posts/presentation/tea_posts_page.dart';

void goTo(BuildContext context, String path) => context.go(path);

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => WelcomePage(),
      routes: [
        GoRoute(
          path: "/register",
          builder: (context, state) {
            return RegistrationPage();
          },
        ),
        GoRoute(
          path: "/login",
          builder: (context, state) {
            return LoginPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: "/main_page",
      builder: (context, state) => MainPage(),
      routes: [
        GoRoute(
          path: "/details",
          builder: (context, state) {
            final data = state.extra as List<dynamic>;
            final tea = data[0] as TeaModel;
            final homeContext = data[1] as BuildContext;
            return DetailsPage(tea: tea, homeContext: homeContext);
          },
        ),
        GoRoute(
          path: "/tea_posts",
          builder: (context, state) {
            return TeaPostsPage();
          },
        ),
      ],
    ),
  ],
);
