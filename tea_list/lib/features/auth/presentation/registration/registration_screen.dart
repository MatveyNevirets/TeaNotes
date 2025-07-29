import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/base_snackbar.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';
import 'package:tea_list/core/widgets/stylized_text_field.dart';
import 'package:tea_list/features/auth/presentation/registration/bloc/registration_bloc.dart';
import 'package:tea_list/internal/routes/application_routes.dart';

class RegistrationScreen extends StatelessWidget {
  RegistrationScreen({super.key});

  final nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      verifyPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void tryToRegisterWithEmail(String name, String email, String password, String verifyPassword) {
      if (password == verifyPassword) {
        context.read<RegistrationBloc>().add(TryRegisterEvent(name: name, email: email, password: password));
      } else {
        showSnackBar(context, "Пароли должны совпадать");
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 244, 230),
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
            if (state is LoadingRegistration) {
              return CircularProgressIndicator(color: AppColors.application3BaseColor, strokeWidth: 4);
            }
            if (state is RegistrationInitial) {
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
                                nameController.text.toString(),
                                emailController.text.toString(),
                                passwordController.text.toString(),
                                verifyPasswordController.text.toString(),
                              ),
                          text: "Регистрация",
                          backgroundColor: AppColors.application2BaseColor,
                          textColor: Colors.black.withAlpha(200),
                          buttonSize: Size(
                            MediaQuery.of(context).size.width / 1.35,
                            MediaQuery.of(context).size.height / 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return CircularProgressIndicator(); // TODO FIX THIS SHIT
          },
        ),
      ),
    );
  }
}
