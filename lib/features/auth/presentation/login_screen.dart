import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/base_snackbar.dart';
import 'package:tea_list/core/widgets/loading_screen.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';
import 'package:tea_list/core/widgets/stylized_text_field.dart';
import 'package:tea_list/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tea_list/internal/routes/application_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: AppColors.applicationBackroundColor),
    );
    return Scaffold(
      backgroundColor: AppColors.applicationBackroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 64),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (BuildContext context, AuthState state) {
            if (state is AuthErrorState) {
              showSnackBar(context, state.message);
            }
            if (state is AuthenticatedState) {
              showSnackBar(context, state.message!);
              goTo(context, "/main_page");
            }
          },
          builder: (context, state) {
            if (state is UnauthenticateState) {
              return LoginScreenWidgets();
            }
            return LoadingScreen();
          },
        ),
      ),
    );
  }
}

class LoginScreenWidgets extends StatelessWidget {
  LoginScreenWidgets({super.key});

  final emailController = TextEditingController(), passwordController = TextEditingController();

  void tryLogin(BuildContext context) {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showSnackBar(context, "Пожалуйста, заполните все необходимые поля");
    } else {
      context.read<AuthBloc>().add(LoginEvent(email: emailController.text, password: passwordController.text));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("assets/images/gaiwan.png", width: MediaQuery.of(context).size.width / 3),
            SizedBox(height: MediaQuery.of(context).size.height / 50),
            Text("TEA NOTES", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 40)),
            Text("Вход в аккаунт", style: Theme.of(context).textTheme.bodyLarge),
            SizedBox(height: MediaQuery.of(context).size.height / 30),
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
            Expanded(child: SizedBox()),
            Center(
              child: StylizedButton(
                onPressed: () => tryLogin(context),
                text: "Войти",
                backgroundColor: AppColors.application2BaseColor,
                textColor: Colors.black.withAlpha(200),
                buttonSize: Size(MediaQuery.of(context).size.width / 1.35, MediaQuery.of(context).size.height / 10),
              ),
            ),
            Expanded(child: SizedBox()),
            Image.asset("assets/images/chaban.png"),
          ],
        ),
      ),
    );
  }
}
