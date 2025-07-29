import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/features/auth/presentation/welcome/bloc/welcome_bloc.dart';
import 'package:tea_list/features/auth/presentation/welcome/welcome_screen.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => WelcomeBloc(), child: WelcomeScreen());
  }
}
