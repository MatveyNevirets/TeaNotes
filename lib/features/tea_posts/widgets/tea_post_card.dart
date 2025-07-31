import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/features/tea_posts/presentation/bloc/tea_posts_bloc.dart';

class TeaPostCard extends StatelessWidget {
  const TeaPostCard({super.key, required this.state, required this.index});

  final FetchedTeaPosts state;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go("/main_page/tea_posts/post", extra: state.teaPosts[index]),
      child: Container(
        margin: EdgeInsets.all(16),
        padding: EdgeInsets.all(16),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.applicationBaseColor,
          boxShadow: [
            BoxShadow(offset: Offset(0, 2), color: AppColors.application2BaseColor, spreadRadius: 1, blurRadius: 1),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(state.teaPosts[index].title, style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: 8),
            Container(color: AppColors.application3BaseColor, height: 2, width: double.maxFinite),
            SizedBox(height: 4),
            Text(
              "${state.teaPosts[index].body.substring(0, 40).trimRight()}...",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}
