import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white)),
      behavior: SnackBarBehavior.floating,
      backgroundColor: AppColors.selectedItemColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      duration: const Duration(seconds: 3),
      animation: CurvedAnimation(parent: kAlwaysDismissedAnimation, curve: Curves.easeInOut),
    ),
  );
}
