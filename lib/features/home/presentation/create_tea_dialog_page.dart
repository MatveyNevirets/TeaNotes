import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/features/create_new_tea/presentation/bloc/create_tea_bloc.dart';
import 'package:tea_list/features/home/domain/repository/tea_list_repository.dart';
import 'package:tea_list/features/home/presentation/create_tea_dailog_screen.dart';

class CreateTeaDialogPage extends StatelessWidget {
  const CreateTeaDialogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final teaListRepository = GetIt.I<TeaListRepository>();
    return BlocProvider(
      create: (BuildContext dialogContext) => CreateTeaBloc(teaListRepository: teaListRepository),
      child: CreateTeaDialogScreen(),
    );
  }
}
