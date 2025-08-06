import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/bloc/ceremony_bloc.dart';

class WarmUpScreen extends StatelessWidget {
  const WarmUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black.withAlpha(180);
    return Scaffold(
      body: Stack(
        children: [
          // This is a title of process text
          Positioned(
            top: 64,
            left: MediaQuery.of(context).size.width / 6,
            right: MediaQuery.of(context).size.width / 6,
            child: Text(
              "Прогрейте посуду",
              textAlign: TextAlign.left,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 40, color: textColor),
            ),
          ),
          // This is our bottom brown part of the screen
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppColors.application3BaseColor,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 2.5,
            ),
          ),
          // This is the image with shadow
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
                "assets/images/teapot_with_cups.png",
                height: MediaQuery.of(context).size.height / 2.5,
              ),
            ),
          ),
          // This is button
          Positioned(
            bottom: MediaQuery.of(context).size.height / 15,
            left: MediaQuery.of(context).size.width / 8,
            right: MediaQuery.of(context).size.width / 8,
            child: StylizedButton(
              buttonSize: Size(double.maxFinite, MediaQuery.of(context).size.height / 12),
              onPressed: () => context.read<CeremonyBloc>().add(OnWarmedUpCeremonyEvent()),
              text: "Готово",
              backgroundColor: AppColors.application2BaseColor,
              textColor: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
