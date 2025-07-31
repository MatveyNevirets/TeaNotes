import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';

class StylizedTextField extends StatelessWidget {
  StylizedTextField({
    super.key,
    this.lableText,
    this.isNumberKeyboard = false,
    this.size,
    this.textColor,
    this.fontSize,
    this.isOutline = false,
    this.onChanged,
    required this.controller,
  });
  final VoidCallback? onChanged;
  String? lableText;
  Size? size;
  double? fontSize;
  TextEditingController controller;
  Color? textColor;
  bool isNumberKeyboard;
  bool isOutline;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall;

    return TextField(
      onChanged: (value) => onChanged?.call(),
      controller: controller,
      style: textStyle!.copyWith(color: textColor ?? textStyle.color, fontSize: fontSize ?? textStyle.fontSize),

      keyboardType: isNumberKeyboard ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
        constraints: size != null ? BoxConstraints(maxHeight: size!.height, maxWidth: size!.width) : null,
        labelText: lableText,
        labelStyle: textStyle.copyWith(color: textColor ?? textStyle.color, fontSize: fontSize ?? textStyle.fontSize),

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
