import 'package:flutter/material.dart';
import 'package:tea_list/core/widgets/tea_type_item.dart';
import 'package:tea_list/shared/domain/enums/tea_types_list.dart';

class TeaTypesTab extends StatefulWidget {
  const TeaTypesTab({super.key, required this.onTeaTypeChanged});

  final Function(int index) onTeaTypeChanged;

  @override
  State<TeaTypesTab> createState() => _TeaTypesTabState();
}

class _TeaTypesTabState extends State<TeaTypesTab> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: teaTypesList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = index;
              widget.onTeaTypeChanged.call(currentIndex);
            });
          },
          child: TeaTypeItem(title: teaTypesList[index], currentIndex: currentIndex, index: index),
        );
      }, //
    );
  }
}
