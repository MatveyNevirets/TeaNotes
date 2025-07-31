import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/features/tea_posts/domain/repository/tea_posts_repository.dart';
import 'package:tea_list/features/tea_posts/presentation/bloc/tea_posts_bloc.dart';
import 'package:tea_list/features/tea_posts/presentation/tea_posts_screen.dart';

class TeaPostsPage extends StatelessWidget {
  const TeaPostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final teaPostsRepository = GetIt.I<TeaPostsRepository>();
    return BlocProvider(
      create: (context) {
        final bloc = TeaPostsBloc(teaPostsRepository);
        bloc.add(TryFetchPostsEvent());
        return bloc;
      },
      child: TeaPostsScreen(),
    );
  }
}
