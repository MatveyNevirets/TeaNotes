import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/features/tea_posts/presentation/bloc/tea_posts_bloc.dart';

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
                  return Text(state.teaPosts[index].title);
                },
              ),
            );
          }
          return CircularProgressIndicator(); // TODO: NORMAL LOADING SCREEN
        },
      ),
    );
  }
}
