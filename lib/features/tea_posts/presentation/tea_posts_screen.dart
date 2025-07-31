// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/widgets/loading_screen.dart';
import 'package:tea_list/features/tea_posts/presentation/bloc/tea_posts_bloc.dart';
import 'package:tea_list/features/tea_posts/widgets/tea_post_card.dart';

class TeaPostsScreen extends StatelessWidget {
  const TeaPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TeaPostsBloc, TeaPostsState>(
        builder: (context, state) {
          if (state is FetchedTeaPosts) {
            return Center(
              child: ListView.builder(
                itemCount: state.teaPosts.length,
                itemBuilder: (context, index) {
                  return TeaPostCard(state: state, index: index);
                },
              ),
            );
          }
          return LoadingScreen();
        },
      ),
    );
  }
}
