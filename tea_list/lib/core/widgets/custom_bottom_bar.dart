import 'package:flutter/material.dart';

class CustomBottomBar extends StatelessWidget {
  CustomBottomBar({super.key, required this.children, this.verticalPadding});

  List<Widget> children;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 5, spreadRadius: 1)],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: verticalPadding ?? 8),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: children),
      ),
    );
  }
}
