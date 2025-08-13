import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/features/home/domain/repository/tea_list_repository.dart';
import 'package:tea_list/features/home/presentation/bloc/home_bloc.dart';
import 'package:tea_list/features/home/presentation/home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.I;

    return BlocProvider(
      create: (context) => HomeBloc(teaListRepository: getIt<TeaListRepository>()),
      child: HomeScreen(),
    );
  }
}
