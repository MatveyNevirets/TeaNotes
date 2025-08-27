import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/features/tea_posts/presentation/bloc/tea_posts_bloc.dart';

// safe substring helper
String _safeSnippet(String? text, [int max = 120]) {
  if (text == null || text.isEmpty) return '';
  final t = text.trim();
  if (t.length <= max) return t;
  return '${t.substring(0, max).trimRight()}...';
}

class TeaPostCard extends StatelessWidget {
  const TeaPostCard({super.key, required this.state, required this.index});

  final FetchedTeaPosts state;
  final int index;

  @override
  Widget build(BuildContext context) {
    final post = state.teaPosts[index];
    final titleStyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontSize: 18, height: 1.1, color: const Color(0xFF2B1A0F));
    final bodyStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontSize: 15, height: 1.4, color: const Color(0xFF2B1A0F).withOpacity(0.9));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.go("/main_page/tea_posts/post", extra: post),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.applicationBaseColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 6,
                  spreadRadius: 0,
                  color: AppColors.application2BaseColor.withAlpha(40),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // small decorative leading circle
                Container(
                  width: 48,
                  height: 48,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(color: AppColors.application3BaseColor, shape: BoxShape.circle),
                  child: const Icon(Icons.local_cafe, size: 22, color: Colors.white),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title ?? '', style: titleStyle),
                      const SizedBox(height: 8),
                      Container(
                        height: 2,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.application3BaseColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _safeSnippet(post.body, 120),
                        style: bodyStyle,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
