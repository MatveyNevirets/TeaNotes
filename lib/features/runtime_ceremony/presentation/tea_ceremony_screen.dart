// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tea_list/core/entities/spill_entity.dart';
import 'package:tea_list/core/models/tea_model.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/are_you_sure_dialog.dart';
import 'package:tea_list/core/widgets/base_snackbar.dart';
import 'package:tea_list/core/widgets/stylized_loading_indicator.dart';
import 'package:tea_list/core/widgets/stylized_text_field.dart';
import 'package:tea_list/core/widgets/tea_types_tab.dart';
import 'package:tea_list/features/runtime_ceremony/domain/timer/timer_tea_ceremony.dart';
import 'package:tea_list/features/runtime_ceremony/presentation/bloc/ceremony_bloc.dart';

class TeaCeremonyScreen extends StatefulWidget {
  const TeaCeremonyScreen({super.key, required this.tea});

  final TeaModel tea;

  @override
  State<TeaCeremonyScreen> createState() => _TeaCeremonyScreenState();
}

class _TeaCeremonyScreenState extends State<TeaCeremonyScreen> {
  List<SpillEntity>? spills;

  int currentIndex = 0;

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required String fieldName,
    String? initialValue,
  }) {
    return StylizedTextField(
      borderWidth: 4,
      borderRadius: 16,
      fontSize: 21,
      isOutline: true,
      lableText: label,
      controller: TextEditingController(text: initialValue ?? "")
        ..selection = TextSelection.fromPosition(TextPosition(offset: (initialValue ?? "").length)),
      onChanged: (value) {
        context.read<CeremonyBloc>().add(
          UpdateSpillFieldEvent(index: currentIndex, fieldName: fieldName, value: value),
        );
      },
    );
  }

  void changeTab(BuildContext context, int index) {
    setState(() {
      context.read<CeremonyBloc>().add(TabChangedEvent(index: index, spills: spills));
      log("change index $index");
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CeremonyBloc, CeremonyState>(
      listener: (context, state) {
        spills = state.spills;
        if (state is ChangedSpillState) {
          currentIndex = state.index;
        }
        if (state is SuccessFinishState) {
          context.go("/main_page");
          showSnackBar(context, "Успешное завершение!");
        }
      },
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder:
                    (dialogContext) => AreYouSureDialog(
                      title: "Вы уверены, что хотите завершить чайную церемонию?",
                      onNot: () => Navigator.of(dialogContext).pop(),
                      onYes: () {
                        Navigator.of(dialogContext).pop();
                        context.read<CeremonyBloc>().add(SuccessFinishEvent(imagePath: widget.tea.imagePath));
                      },
                    ),
              );
            },
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<CeremonyBloc, CeremonyState>(
                  builder: (builderContext, state) {
                    spills = state.spills;

                    if (state is StartCeremonyState) {
                      return _StartSpillTimerWidget(
                        onClick: () => builderContext.read<CeremonyBloc>().add(StartSpillTimerEvent()),
                      );
                    } else if (state is SpillStartState) {
                      return _SpillTimerInProcessWidget(
                        onClick: () {
                          builderContext.read<CeremonyBloc>().add(StopSpillTimerEvent());
                          changeTab(context, spills!.length);
                        },
                      );
                    } else if (state is SpillStopState || state is ChangedSpillState) {
                      return _NextSpillTimerWidget(
                        onClick: () {
                          builderContext.read<CeremonyBloc>().add(StartSpillTimerEvent());
                        },
                      );
                    }
                    return StylizedLoadingIndicator();
                  },
                ),
                SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.application3BaseColor,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: AppColors.application3BaseColor,
                        spreadRadius: 1,
                        blurRadius: 3,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(8),
                  height: 70,
                  child: BlocBuilder<CeremonyBloc, CeremonyState>(
                    builder: (context, state) {
                      return TeaTabWidget(
                        onTabChanged: (index) => changeTab(context, index),
                        children: List.generate(spills?.length ?? 0, (index) => "Пролив ${index + 1}"),
                      );
                    },
                  ),
                ),
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.white.withAlpha(30),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: BlocBuilder<CeremonyBloc, CeremonyState>(
                            builder: (context, state) {
                              log(state.runtimeType.toString());
                              if (state.spills.isEmpty) {
                                return SizedBox(
                                  height: MediaQuery.of(context).size.height / 2.65,
                                  child: Center(
                                    child: Text(
                                      "Приятного чаепития! :)",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                );
                              } else if (state is ChangedSpillState ||
                                  state is SpillStopState ||
                                  state is SpillStartState) {
                                final currentSpill = state.spills[currentIndex];
                                return Column(
                                  mainAxisSize: MainAxisSize.min,

                                  children: [
                                    SizedBox(height: 20),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Аромат", style: Theme.of(context).textTheme.bodyLarge),
                                    ),
                                    SizedBox(height: 25),
                                    _buildTextField(
                                      context,
                                      label: "Из под крышки гайвани",
                                      fieldName: "smellUnderLid",
                                      initialValue: currentSpill.smellUnderLid,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildTextField(
                                      context,
                                      label: "Из гайвани",
                                      fieldName: "smellFromGaiwan",
                                      initialValue: currentSpill.smellFromGaiwan,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildTextField(
                                      context,
                                      label: "Из пустой пиалы",
                                      fieldName: "smellFromEmptyBowl",
                                      initialValue: currentSpill.smellFromEmptyBowl,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildTextField(
                                      context,
                                      label: "Из пустого Ча Хай",
                                      fieldName: "smellFromEmptyChaHai",
                                      initialValue: currentSpill.smellFromEmptyChaHai,
                                    ),

                                    SizedBox(height: 30),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Пролив", style: Theme.of(context).textTheme.bodyLarge),
                                    ),
                                    SizedBox(height: 25),
                                    _buildTextField(
                                      context,
                                      label: "Цвет",
                                      fieldName: "colorOfTea",
                                      initialValue: currentSpill.colorOfTea,
                                    ),
                                    const SizedBox(height: 20),
                                    _buildTextField(
                                      context,
                                      label: "Вкус",
                                      fieldName: "tasteOfTea",
                                      initialValue: currentSpill.tasteOfTea,
                                    ),
                                    SizedBox(height: 30),
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text("Прочее", style: Theme.of(context).textTheme.bodyLarge),
                                    ),
                                    SizedBox(height: 25),
                                    _buildTextField(
                                      context,
                                      label: "Общие впечатления",
                                      fieldName: "impressions",
                                      initialValue: currentSpill.impressions,
                                    ),
                                    const SizedBox(height: 25),
                                    _buildTextField(
                                      context,
                                      label: "Состояние",
                                      fieldName: "teaState",
                                      initialValue: currentSpill.teaState,
                                    ),
                                    SizedBox(height: 40),
                                  ],
                                );
                              }
                              return Container();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SpillTimerInProcessWidget extends StatelessWidget {
  const _SpillTimerInProcessWidget({required this.onClick});

  final VoidCallback onClick;

  String transformTime(int? seconds) {
    if (seconds != null) {
      final minutesTimer = ((seconds / 60) % 60).floor();
      final secondsTimer = (seconds % 60);
      return "${minutesTimer.toString().padLeft(2, '0')}:${secondsTimer.toString().padLeft(2, '0')}";
    } else {
      return "00:00";
    }
  }

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
            child: StreamBuilder(
              stream: TimerTeaCeremony().tick(),
              builder: (context, asyncSnapshot) {
                return Text(
                  textAlign: TextAlign.center,
                  transformTime(asyncSnapshot.data),
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.white, fontSize: 52),
                );
              },
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
