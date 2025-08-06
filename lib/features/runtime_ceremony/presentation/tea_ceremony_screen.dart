import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/stylized_loading_indicator.dart';
import 'package:tea_list/core/widgets/tea_types_tab.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/bloc/ceremony_bloc.dart';

class TeaCeremonyScreen extends StatelessWidget {
  const TeaCeremonyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<CeremonyBloc, CeremonyState>(
              builder: (context, state) {
                if (state is StartCeremonyState) {
                  return _StartSpillTimerWidget(
                    onClick: () => context.read<CeremonyBloc>().add(StartSpillTimerEvent()),
                  );
                } else if (state is SpillStartState) {
                  return _SpillTimerInProcessWidget(
                    onClick: () => context.read<CeremonyBloc>().add(StopSpillTimerEvent()),
                  );
                } else if (state is SpillStopState) {
                  return _NextSpillTimerWidget(onClick: () => context.read<CeremonyBloc>().add(StartSpillTimerEvent()));
                }
                return StylizedLoadingIndicator();
              },
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(color: AppColors.application3BaseColor),
              padding: EdgeInsets.all(8),
              height: 70,
              child: TeaTabWidget(onTabChanged: (index) {}, children: ["Пролив 1", "Пролив 2"]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      color: Colors.white.withAlpha(60),
                      height: MediaQuery.of(context).size.height / 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(height: 100, color: AppColors.application3BaseColor),
                            SizedBox(height: 20),
                            Container(height: 100, color: AppColors.application3BaseColor),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SpillTimerInProcessWidget extends StatelessWidget {
  const _SpillTimerInProcessWidget({required this.onClick});

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick.call(),
      child: Stack(
        children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 64, bottom: 16),
              child: Image.asset("assets/images/timer_background.png", width: MediaQuery.of(context).size.width / 1.2),
            ),
          ),

          Positioned(
            left: MediaQuery.of(context).size.width / 5.5,
            right: MediaQuery.of(context).size.width / 5.5,
            top: MediaQuery.of(context).size.height / 5,
            child: Text(
              textAlign: TextAlign.center,
              "00:12",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontSize: 52),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 5.5,
            right: MediaQuery.of(context).size.width / 5.5,
            top: MediaQuery.of(context).size.height / 3.5,
            child: Icon(Icons.pause, size: 80),
          ),
        ],
      ),
    );
  }
}

class _NextSpillTimerWidget extends StatelessWidget {
  const _NextSpillTimerWidget({required this.onClick});

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick.call(),
      child: Stack(
        children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 64, bottom: 16),
              child: Image.asset("assets/images/timer_background.png", width: MediaQuery.of(context).size.width / 1.2),
            ),
          ),

          Positioned(
            left: MediaQuery.of(context).size.width / 5.5,
            right: MediaQuery.of(context).size.width / 5.5,
            top: MediaQuery.of(context).size.height / 6,
            child: Text(
              textAlign: TextAlign.center,
              "Сделать следующий пролив",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontSize: 24),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 5.5,
            right: MediaQuery.of(context).size.width / 5.5,
            top: MediaQuery.of(context).size.height / 3.5,
            child: Icon(Icons.play_arrow_rounded, size: 84),
          ),
        ],
      ),
    );
  }
}

class _StartSpillTimerWidget extends StatelessWidget {
  const _StartSpillTimerWidget({required this.onClick});
  final VoidCallback onClick;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick.call(),
      child: Stack(
        children: [
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(top: 64, bottom: 16),
              child: Image.asset("assets/images/timer_background.png", width: MediaQuery.of(context).size.width / 1.2),
            ),
          ),

          Positioned(
            left: MediaQuery.of(context).size.width / 5.5,
            right: MediaQuery.of(context).size.width / 5.5,
            top: MediaQuery.of(context).size.height / 6,
            child: Text(
              textAlign: TextAlign.center,
              "Сделать первый пролив",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 5.5,
            right: MediaQuery.of(context).size.width / 5.5,
            top: MediaQuery.of(context).size.height / 3.5,
            child: Icon(Icons.play_arrow_rounded, size: 84),
          ),
        ],
      ),
    );
  }
}
