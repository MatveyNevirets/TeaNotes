// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tea_list/core/models/spill_model.dart';
import 'package:tea_list/core/styles/app_colors.dart';

class SpillCardWidget extends StatelessWidget {
  const SpillCardWidget({super.key, required this.spill, required this.index});

  final SpillModel spill;
  final int index;
  final double separatorsWidth = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(color: Colors.black.withAlpha(190), width: separatorsWidth),
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BuildHeaderWidget(index: index, separatorsWidth: separatorsWidth),
          BuildSmellPartWidget(spill: spill, separatorsWidth: separatorsWidth),
          BuildSpillPartWidget(spill: spill, separatorsWidth: separatorsWidth),
          BuildOtherPartWidget(spill: spill),
          SizedBox(height: MediaQuery.of(context).size.height / 50),
        ],
      ),
    );
  }
}

class BuildOtherPartWidget extends StatelessWidget {
  const BuildOtherPartWidget({super.key, required this.spill});

  final SpillModel spill;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Прочее", style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: MediaQuery.of(context).size.height / 30),
        Text("Общие впечатления:", style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
        Container(
          decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(spill.impressions ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        Text("Состояние:", style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
        Container(
          decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(spill.teaState ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ),
      ],
    );
  }
}

class BuildSpillPartWidget extends StatelessWidget {
  const BuildSpillPartWidget({super.key, required this.spill, required this.separatorsWidth});

  final SpillModel spill;
  final double separatorsWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Пролив", style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: MediaQuery.of(context).size.height / 30),
        Text("Цвет:", style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
        Container(
          decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(spill.colorOfTea ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        Text("Вкус:", style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
        Container(
          decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(spill.tasteOfTea ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        Container(
          height: separatorsWidth,
          width: double.maxFinite,
          decoration: BoxDecoration(color: Colors.black.withAlpha(190), borderRadius: BorderRadius.circular(8)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
      ],
    );
  }
}

class BuildSmellPartWidget extends StatelessWidget {
  const BuildSmellPartWidget({super.key, required this.spill, required this.separatorsWidth});

  final SpillModel spill;
  final double separatorsWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Аромат", style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(height: MediaQuery.of(context).size.height / 30),
        Text("Под крышкой гайвани:", style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
        Container(
          decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(spill.smellUnderLid ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        Text("Из гайвани:", style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
        Container(
          decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(spill.smellFromGaiwan ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        Text("Из пустой пиалы:", style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
        Container(
          decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(spill.smellFromEmptyBowl ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        Text("Из пустого Ча Хай:", style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
        Container(
          decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: Text(spill.smellFromEmptyChaHai ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 40),
        Container(
          height: separatorsWidth,
          width: double.maxFinite,
          decoration: BoxDecoration(color: Colors.black.withAlpha(190), borderRadius: BorderRadius.circular(8)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
      ],
    );
  }
}

class BuildHeaderWidget extends StatelessWidget {
  const BuildHeaderWidget({super.key, required this.index, required this.separatorsWidth});

  final int index;
  final double separatorsWidth;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text("Пролив ${index + 1}"),
            Expanded(child: SizedBox()),
            Container(
              height: 40,
              width: separatorsWidth,
              decoration: BoxDecoration(color: Colors.black.withAlpha(190), borderRadius: BorderRadius.circular(8)),
            ),
            Expanded(child: SizedBox()),
            Column(crossAxisAlignment: CrossAxisAlignment.center, children: [Text("Время:"), Text("00:00")]),
            SizedBox(width: 16),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
        Container(
          height: separatorsWidth,
          width: double.maxFinite,
          decoration: BoxDecoration(color: Colors.black.withAlpha(190), borderRadius: BorderRadius.circular(8)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height / 70),
      ],
    );
  }
}
