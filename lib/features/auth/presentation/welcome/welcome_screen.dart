import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/base_snackbar.dart';
import 'package:tea_list/core/widgets/loading_screen.dart';
import 'package:tea_list/core/widgets/stylized_button.dart';
import 'package:tea_list/features/auth/presentation/welcome/bloc/welcome_bloc.dart';
import 'package:tea_list/internal/routes/application_routes.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.applicationBackroundColor,
      body: Padding(
        padding: const EdgeInsets.only(left: 32, right: 32, bottom: 32, top: 64),
        child: BlocConsumer<WelcomeBloc, WelcomeState>(
          listener: (context, state) {
            if (state is WelcomeErrorState) {
              showSnackBar(context, state.message);
            } else if (state is WelcomeSuccessSignInState) {
              goTo(context, "/main_page");
              showSnackBar(context, state.message);
            }
          },
          builder: (context, state) {
            if (state is WelcomeInitial) {
              return WelcomeScreenWidget();
            }
            return LoadingScreen();
          },
        ),
      ),
    );
  }
}

class WelcomeScreenWidget extends StatelessWidget {
  const WelcomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset("assets/images/gaiwan.png", width: MediaQuery.of(context).size.width / 3),
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        Text("TEA NOTES", style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 40)),
        SizedBox(height: MediaQuery.of(context).size.height / 15),
        StylizedButton(
          onPressed: () => goTo(context, "/login"),
          text: "Войти",
          backgroundColor: AppColors.application2BaseColor,
          textColor: Colors.black.withAlpha(200),
          buttonSize: Size(MediaQuery.of(context).size.width / 1.35, MediaQuery.of(context).size.height / 10),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 50),
        StylizedButton(
          onPressed: () => goTo(context, "/register"),
          text: "Регистрация",
          backgroundColor: AppColors.application3BaseColor,
          textColor: Colors.black.withAlpha(200),
          buttonSize: Size(MediaQuery.of(context).size.width / 1.35, MediaQuery.of(context).size.height / 10),
        ),
        Expanded(flex: 2, child: SizedBox()),
        GestureDetector(
          onTap: () => context.read<WelcomeBloc>().add(TryGoogleSignInEvent()),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 18,
            child: Image.asset("assets/images/google_icon.png"),
          ),
        ),
        Text(
          "Вход через",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 12, color: Colors.black.withAlpha(150)),
        ),
        Expanded(child: SizedBox()),
        Image.asset("assets/images/chaban.png"),
        SizedBox(height: MediaQuery.of(context).size.height / 100),
        Text(
          "Добро пожаловать на чайную церемонию!",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Colors.black.withAlpha(150)),
        ),
      ],
    );
  }
}
