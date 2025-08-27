// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tea_list/core/models/ceremony_model.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/features/notes_details/widgets/spill_card_widget.dart';

class NotesDetailsScreen extends StatelessWidget {
  const NotesDetailsScreen({super.key, required this.ceremony, required this.index});

  final CeremonyModel ceremony;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height / 2.6,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
                child: Center(
                  child: Column(
                    children: [
                      Image.asset("assets/images/gaiwan.png", width: MediaQuery.of(context).size.width / 3),
                      SizedBox(height: MediaQuery.of(context).size.height / 50),
                      Text(
                        "Церемония номер ${index + 1}",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 20),
                      Container(
                        height: 4,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(190),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: ceremony.spills.length + 1,
            itemBuilder: (context, index) {
              return index == 0
                  ? _buildCeremonyOther(ceremony: ceremony)
                  : SpillCardWidget(spill: ceremony.spills[index - 1], index: index - 1);
            },
          ),
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class _buildCeremonyOther extends StatelessWidget {
  const _buildCeremonyOther({required this.ceremony});
  final CeremonyModel ceremony;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(30),
        borderRadius: BorderRadius.circular(16),
        border: BoxBorder.all(color: Colors.black.withAlpha(190), width: 4),
      ),
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Информация", style: Theme.of(context).textTheme.bodyLarge),
          SizedBox(height: MediaQuery.of(context).size.height / 30),
          Text("Аромат сухого листа:", style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: MediaQuery.of(context).size.height / 70),
          Container(
            decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(ceremony.smellOfDryLeaves ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          Text("Граммовка:", style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: MediaQuery.of(context).size.height / 70),
          Container(
            decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  "${ceremony.weightOfTea} гр." ?? "Тут пусто",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          Text("Объем посуды:", style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: MediaQuery.of(context).size.height / 70),
          Container(
            decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  ceremony.capacity == null ? "Тут пусто" : "${ceremony.capacity} мл.",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          Text("Материал посуды:", style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: MediaQuery.of(context).size.height / 70),
          Container(
            decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(ceremony.material ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          Text("Температура воды:", style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: MediaQuery.of(context).size.height / 70),
          Container(
            decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  ceremony.temperature == null ? "Тут пусто" : "${ceremony.temperature} C",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
          Text("Прочее:", style: Theme.of(context).textTheme.bodyMedium),
          SizedBox(height: MediaQuery.of(context).size.height / 70),
          Container(
            decoration: BoxDecoration(color: AppColors.applicationBaseColor, borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: Text(ceremony.other ?? "Тут пусто", style: Theme.of(context).textTheme.bodyMedium),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 40),
        ],
      ),
    );
  }
}
