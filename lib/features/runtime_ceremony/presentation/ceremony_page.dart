import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/features/runtime_ceremony/data/datasources/remote/remote_firebase_datasource.dart';
import 'package:tea_list/features/runtime_ceremony/data/repository/runtime_ceremony_repository_impl.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/bloc/ceremony_bloc.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/tea_ceremony_main.dart';

class CeremonyPage extends StatelessWidget {
  const CeremonyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Then fix this shit
    return BlocProvider(
      create:
          (context) => CeremonyBloc(
            runtimeCeremonyRepository: RuntimeCeremonyRepositoryImpl(
              remoteDatasource: RemoteFirebaseDatasource(),
              isConnection: true,
            ),
          ),
      child: TeaCeremonyMain(),
    );
  }
}
