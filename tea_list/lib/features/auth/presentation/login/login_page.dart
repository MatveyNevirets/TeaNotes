import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tea_list/features/auth/domain/repository/auth_repository.dart';
import 'package:tea_list/features/auth/presentation/login/bloc/login_bloc.dart';
import 'package:tea_list/features/auth/presentation/login/login_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = GetIt.I<AuthRepository>();

    return BlocProvider(create: (context) => LoginBloc(authRepository), child: LoginScreen());
  }
}
