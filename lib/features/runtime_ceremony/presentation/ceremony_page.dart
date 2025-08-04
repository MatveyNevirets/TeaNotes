import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/bloc/ceremony_bloc.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/tea_ceremony_main.dart';

class CeremonyPage extends StatelessWidget {
  const CeremonyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => CeremonyBloc(), child: TeaCeremonyMain());
  }
}
