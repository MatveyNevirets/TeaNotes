import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';

class StylizedTextField extends StatelessWidget {
  StylizedTextField({
    super.key,
    this.lableText,
    this.isNumberKeyboard = false,
    this.size,
    this.fontSize,
    this.isOutline = false,
    required this.controller,
  });
  String? lableText;
  Size? size;
  double? fontSize;
  TextEditingController controller;
  bool isNumberKeyboard;
  bool isOutline;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style:
          fontSize != null
              ? Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: fontSize)
              : Theme.of(context).textTheme.bodySmall,

      keyboardType: isNumberKeyboard ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        constraints: size != null ? BoxConstraints(maxHeight: size!.height, maxWidth: size!.width) : null,
        labelText: lableText,
        labelStyle:
            fontSize != null
                ? Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: fontSize)
                : Theme.of(context).textTheme.bodySmall,
        focusedBorder:
            isOutline
                ? OutlineInputBorder(borderSide: BorderSide(width: 3, color: AppColors.selectedItemColor))
                : UnderlineInputBorder(borderSide: BorderSide(width: 3, color: AppColors.selectedItemColor)),
        enabledBorder:
            isOutline
                ? OutlineInputBorder(borderSide: BorderSide(width: 1.5, color: AppColors.applicationBaseColor))
                : UnderlineInputBorder(borderSide: BorderSide(width: 1.5, color: AppColors.applicationBaseColor)),
      ),
    );
  }
}
