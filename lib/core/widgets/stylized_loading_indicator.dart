import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tea_list/core/styles/app_colors.dart';

class StylizedLoadingIndicator extends StatelessWidget {
  const StylizedLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SpinKitWaveSpinner(
      color: AppColors.application3BaseColor,
      waveColor: AppColors.applicationBaseColor,
      trackColor: AppColors.application2BaseColor,
      size: MediaQuery.of(context).size.width / 2,
    );
  }
}
