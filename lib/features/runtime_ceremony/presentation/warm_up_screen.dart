import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/bloc/ceremony_bloc.dart';

class WarmUpScreen extends StatelessWidget {
  const WarmUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: AppColors.application3BaseColor,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height / 3,
            ),
          ),
          Positioned(top: 20, child: Image.asset("assets/images/teapot_with_cups.png")),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: () => context.read<CeremonyBloc>().add(OnWarmedUpCeremonyEvent()),
              child: Text("Готово"),
            ),
          ),
        ],
      ),
    );
  }
}
