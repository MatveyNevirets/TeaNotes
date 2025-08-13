import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';

class AreYouSureDialog extends StatelessWidget {
  const AreYouSureDialog({super.key, required this.onNot, required this.onYes, required this.title});

  final VoidCallback onNot;
  final VoidCallback onYes;

  final String title;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(width: 5, color: AppColors.application3BaseColor),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Text(title, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),

      actions: [
        Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StylizedButton(
                onPressed: () => onNot.call(),
                text: "Нет",
                fontSize: 18,
                backgroundColor: AppColors.application3BaseColor,
              ),
              SizedBox(width: MediaQuery.of(context).size.width / 15),
              StylizedButton(
                onPressed: () => onYes.call(),
                text: "Да",
                fontSize: 18,
                backgroundColor: AppColors.applicationBaseColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
