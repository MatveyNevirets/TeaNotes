import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/widgets/loading_screen.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/bloc/ceremony_bloc.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/clear_tea_screen.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/tea_ceremony_screen.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/warm_up_screen.dart';

class TeaCeremonyMain extends StatelessWidget {
  const TeaCeremonyMain({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CeremonyBloc, CeremonyState>(
      builder: (context, state) {
        if (state is CeremonyInitial) {
          return WarmUpScreen();
        }
        if (state is ClearTeaCeremonyState) {
          return ClearTeaScreen();
        }
        if (state is StartCeremonyState ||
            state is SpillStartState ||
            state is SpillStopState ||
            state is ChangedSpillState) {
          return TeaCeremonyScreen();
        }

        return LoadingScreen();
      },
    );
  }
}
