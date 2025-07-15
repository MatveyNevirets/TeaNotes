import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/features/home/data/datasource/remote_source.dart';
import 'package:tea_list/features/home/data/repository/tea_list_repository_impl.dart';
import 'package:tea_list/features/home/presentation/bloc/home_bloc.dart';
import 'package:tea_list/features/home/presentation/home_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeBloc(teaListRepository: TeaListRepositoryImpl(RemoteDataSource())), child: HomeScreen());
  }
}
