import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/stylized_loading_indicator.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StylizedLoadingIndicator(),

            Text(
              "Загрузка...",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.application3BaseColor),
            ),
          ],
        ),
      ),
    );
  }
}
