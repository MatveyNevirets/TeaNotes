import 'package:flutter/material.dart';
import 'package:tea_list/core/consts/tea_types_list.dart';
import 'package:tea_list/core/widgets/tea_type_item.dart';

class TeaTabWidget extends StatefulWidget {
  const TeaTabWidget({super.key, required this.onTabChanged, this.children});

  final Function(int index) onTabChanged;
  final List<String>? children;

  @override
  State<TeaTabWidget> createState() => _TeaTabWidgetState();
}

class _TeaTabWidgetState extends State<TeaTabWidget> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.children?.length ?? teaTypesList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              currentIndex = index;
              widget.onTabChanged.call(currentIndex);
            });
          },
          child: TeaTypeItem(
            title: widget.children?[index] ?? teaTypesList[index],
            currentIndex: currentIndex,
            index: index,
          ),
        );
      }, //
    );
  }
}
