import 'package:flutter/material.dart';
import 'package:tea_list/core/consts/tea_types_list.dart';
import 'package:tea_list/core/widgets/tea_type_item.dart';

class TeaTabWidget extends StatelessWidget {
  const TeaTabWidget({super.key, required this.onTabChanged, this.children, required this.currentIndex});

  final Function(int index) onTabChanged;
  final List<String>? children;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: children?.length ?? teaTypesList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => onTabChanged.call(index),
          child: TeaTypeItem(title: children?[index] ?? teaTypesList[index], currentIndex: currentIndex, index: index),
        );
      }, //
    );
  }
}
