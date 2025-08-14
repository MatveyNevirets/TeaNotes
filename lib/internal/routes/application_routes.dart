import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tea_list/core/models/ceremony_model.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/auth/presentation/login/login_page.dart';
import 'package:tea_list/features/auth/presentation/registration/registration_page.dart';
import 'package:tea_list/features/auth/presentation/welcome/welcome_page.dart';
import 'package:tea_list/features/details/presentation/details_page.dart';
import 'package:tea_list/features/main_page/main_page.dart';
import 'package:tea_list/features/notes_details/presentation/notes_details_screen.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/ceremony_page.dart';
import 'package:tea_list/features/tea_post_details/presentation/tea_post_details.dart';
import 'package:tea_list/features/tea_posts/domain/entity/tea_post_entity.dart';
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
          path: '/tea_ceremony',
          builder: (context, state) {
            final tea = state.extra as TeaModel;
            return CeremonyPage(tea: tea);
          },
        ),
        GoRoute(
          path: "/notes_details",
          builder: (context, state) {
            final data = state.extra as List<dynamic>;
            final ceremony = data[0] as CeremonyModel;
            final ceremonyIndex = data[1] as int;
            return NotesDetailsScreen(ceremony: ceremony, index: ceremonyIndex);
          },
        ),
        GoRoute(
          path: "/tea_posts",
          routes: [
            GoRoute(
              path: "/post",
              builder: (context, state) {
                final tea = state.extra as TeaPostEntity;
                return TeaPostDetails(teaPostEntity: tea);
              },
            ),
          ],
          builder: (context, state) {
            return TeaPostsPage();
          },
        ),
      ],
    ),
  ],
);
