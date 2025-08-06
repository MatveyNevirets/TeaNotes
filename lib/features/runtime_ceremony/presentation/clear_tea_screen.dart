import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/bloc/ceremony_bloc.dart';

class ClearTeaScreen extends StatelessWidget {
  const ClearTeaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 64,
            left: MediaQuery.of(context).size.width / 6,
            right: MediaQuery.of(context).size.width / 6,
            child: Text(
              "Промойте чай",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 40, color: Colors.black.withAlpha(180)),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppColors.application3BaseColor,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 2.5,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: AppColors.applicationBaseColor,
                    spreadRadius: 1,
                    blurRadius: 3,
                  ),
                ],
                borderRadius: BorderRadius.circular(90),
              ),
              child: Image.asset(
                "assets/images/gaiwan_with_water.png",
                height: MediaQuery.of(context).size.height / 2.5,
              ),
            ),
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 15,
            left: MediaQuery.of(context).size.width / 8,
            right: MediaQuery.of(context).size.width / 8,
            child: StylizedButton(
              buttonSize: Size(double.maxFinite, MediaQuery.of(context).size.height / 12),
              onPressed: () => context.read<CeremonyBloc>().add(OnClearedTeaCeremonyEvent()),
              text: "Готово",
              backgroundColor: AppColors.application2BaseColor,
              textColor: Colors.black.withAlpha(180),
            ),
          ),
        ],
      ),
    );
  }
}
