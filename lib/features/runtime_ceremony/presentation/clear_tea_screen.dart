import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/bloc/ceremony_bloc.dart';

class ClearTeaScreen extends StatelessWidget {
  const ClearTeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Чисть ча"),
          ElevatedButton(
            onPressed: () => context.read<CeremonyBloc>().add(OnClearedTeaCeremonyEvent()),
            child: Text("Готово"),
          ),
        ],
      ),
    );
  }
}
