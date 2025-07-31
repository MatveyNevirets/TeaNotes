import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/features/details/presentation/bloc/details_bloc.dart';
import 'package:tea_list/features/details/presentation/details_screen.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, required this.tea, required this.homeContext});
  final TeaModel tea;
  final BuildContext homeContext;

  @override
  Widget build(BuildContext context) {
    final auth = GetIt.I<FirebaseAuth>();

    return BlocProvider(
      create: (context) => DetailsBloc(auth: auth),
      child: DetailsScreen(tea: tea, homeContext: homeContext),
    );
  }
}
