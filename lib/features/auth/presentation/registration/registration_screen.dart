import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/base_snackbar.dart';
import 'package:tea_list/core/widgets/loading_screen.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';
import 'package:tea_list/core/widgets/stylized_text_field.dart';
import 'package:tea_list/features/auth/presentation/registration/bloc/registration_bloc.dart';
import 'package:tea_list/internal/routes/application_routes.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.applicationBackroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 64),
        child: BlocConsumer<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is LetterHasBeenSended) {
              showSnackBar(context, state.message);
            } else if (state is SuccessRegistration) {
              showSnackBar(context, state.message);
              goTo(context, "/main_page");
            } else if (state is ErrorRegistration) {
              log("Error into BLoC registration. Error: ${state.error} StackTrace: ${state.stack}");
              showSnackBar(context, "Что-то пошло не так :(");
            }
          },
          builder: (context, state) {
            if (state is RegistrationInitial) {
              return RegistrationScreenWidget(message: state.message);
            }
            return LoadingScreen();
          },
        ),
      ),
    );
  }
}

class RegistrationScreenWidget extends StatelessWidget {
  final String? message;

  RegistrationScreenWidget({super.key, this.message});

  final nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      verifyPasswordController = TextEditingController();

  Future<void> showDelayedSnackbar(BuildContext context) async {
    if (message != null) {
      await Future.delayed(Duration(milliseconds: 50));
      // ignore: use_build_context_synchronously
      showSnackBar(context, message!);
    } else {
      return;
    }
  }

  void tryToRegisterWithEmail(BuildContext context, String name, String email, String password, String verifyPassword) {
    if (password == verifyPassword) {
      // Send event to BLoC
      context.read<RegistrationBloc>().add(TryRegisterEvent(name: name, email: email, password: password));
    } else {
      showSnackBar(context, "Пароли должны совпадать");
    }
  }

  @override
  Widget build(BuildContext context) {
    // If we tried register and account with our email
    // Has exists we gives message from BLoC state
    // And shows this one to user
    showDelayedSnackbar(context);

    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/gaiwan.png", width: MediaQuery.of(context).size.width / 3),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Text("TEA NOTES", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 40)),
            Text("Регистрация", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
            StylizedTextField(
              lableText: "Имя",
              fontSize: 21,
              isOutline: true,
              controller: nameController,
              size: Size(double.maxFinite, MediaQuery.of(context).size.height / 15),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            StylizedTextField(
              lableText: "Почта",
              fontSize: 21,
              isOutline: true,
              controller: emailController,
              size: Size(double.maxFinite, MediaQuery.of(context).size.height / 15),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            StylizedTextField(
              lableText: "Пароль",
              fontSize: 21,
              isOutline: true,
              controller: passwordController,
              size: Size(double.maxFinite, MediaQuery.of(context).size.height / 15),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            StylizedTextField(
              lableText: "Подтвердите пароль",
              fontSize: 21,
              isOutline: true,
              controller: verifyPasswordController,
              size: Size(double.maxFinite, MediaQuery.of(context).size.height / 15),
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 10),
            Center(
              child: StylizedButton(
                onPressed:
                    () => tryToRegisterWithEmail(
                      context,
                      nameController.text.toString(),
                      emailController.text.toString(),
                      passwordController.text.toString(),
                      verifyPasswordController.text.toString(),
                    ),
                text: "Регистрация",
                backgroundColor: AppColors.application2BaseColor,
                textColor: Colors.black.withAlpha(200),
                buttonSize: Size(MediaQuery.of(context).size.width / 1.35, MediaQuery.of(context).size.height / 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
