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
    this.borderWidth,
    this.borderRadius,
    this.isOutline = false,
    this.onChanged,
    required this.controller,
  });
  final Function(String)? onChanged;
  String? lableText;
  Size? size;
  double? borderWidth;
  double? borderRadius;
  double? fontSize;
  TextEditingController controller;
  Color? textColor;
  bool isNumberKeyboard;
  bool isOutline;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodySmall;

    return TextField(
      onChanged: (value) => onChanged?.call(value),
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
                ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                  borderSide: BorderSide(width: borderWidth ?? 3, color: AppColors.selectedItemColor),
                )
                : UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                  borderSide: BorderSide(width: borderWidth ?? 3, color: AppColors.selectedItemColor),
                ),
        enabledBorder:
            isOutline
                ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                  borderSide: BorderSide(width: borderWidth ?? 1.5, color: AppColors.applicationBaseColor),
                )
                : UnderlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius ?? 8),
                  borderSide: BorderSide(width: borderWidth ?? 1.5, color: AppColors.applicationBaseColor),
                ),
      ),
    );
  }
}
