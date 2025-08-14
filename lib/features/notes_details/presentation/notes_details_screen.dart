// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:tea_list/core/models/ceremony_model.dart';
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
            expandedHeight: MediaQuery.of(context).size.height / 3,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverList.builder(
            itemCount: ceremony.spills.length,
            itemBuilder: (context, index) {
              return SpillCardWidget(spill: ceremony.spills[index], index: index);
            },
          ),
        ],
      ),
    );
  }
}
