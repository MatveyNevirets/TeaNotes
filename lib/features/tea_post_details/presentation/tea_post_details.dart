// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/features/tea_posts/domain/entity/tea_post_entity.dart';

class TeaPostDetails extends StatelessWidget {
  const TeaPostDetails({super.key, required this.teaPostEntity});

  final TeaPostEntity teaPostEntity;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(
      context,
    ).textTheme.bodyLarge?.copyWith(fontSize: 22, height: 1.05, color: const Color(0xFF2B1A0F));
    final bodyStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(fontSize: 16, height: 1.6, color: const Color(0xFF2B1A0F));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2B1A0F)),
          onPressed: () => Navigator.of(context).maybePop(),
        ),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(teaPostEntity.title, style: titleStyle),
            const SizedBox(height: 20),
            // декоративный разделитель в тон палитры
            Container(
              height: 4,
              width: double.infinity,
              decoration: BoxDecoration(color: AppColors.application3BaseColor, borderRadius: BorderRadius.circular(4)),
            ),
            const SizedBox(height: 20),
            Text(teaPostEntity.body, style: bodyStyle),
          ],
        ),
      ),
    );
  }
}
