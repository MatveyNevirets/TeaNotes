import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/features/create_new_tea/presentation/create_new_tea_screen.dart';

class CreateTeaDialogScreen extends StatelessWidget {
  const CreateTeaDialogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      backgroundColor: AppColors.applicationBackroundColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 10, color: Colors.black),
        borderRadius: BorderRadiusGeometry.circular(32),
      ),
      insetPadding: const EdgeInsets.all(16),
      content: CreateNewTeaScreen(previousContext: context),
    );
  }
}
