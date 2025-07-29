import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';
import 'package:tea_list/features/auth/presentation/registration/bloc/registration_bloc.dart';
import 'package:tea_list/features/auth/presentation/registration/registration_screen.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = GetIt.I<AuthRepository>();
    return BlocProvider(create: (context) => RegistrationBloc(authRepository), child: RegistrationScreen());
  }
}
