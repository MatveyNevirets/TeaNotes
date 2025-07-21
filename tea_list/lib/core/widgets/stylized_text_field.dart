import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';

class StylizedTextField extends StatelessWidget {
  StylizedTextField({super.key, this.lableText});
  String? lableText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: lableText,
        labelStyle: Theme.of(context).textTheme.bodySmall,
        focusedBorder: UnderlineInputBorder(borderSide: BorderSide(width: 3, color: AppColors.selectedItemColor)),
        enabledBorder: UnderlineInputBorder(borderSide: BorderSide(width: 1.5, color: AppColors.applicationBaseColor)),
      ),
    );
  }
}
