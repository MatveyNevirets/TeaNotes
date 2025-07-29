import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';

void showOverlaySnackBar(BuildContext context, String text) {
  final overlay = Overlay.of(context);

  final entry = OverlayEntry(
    builder:
        (_) => Positioned(
          bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.selectedItemColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))],
              ),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
  );

  overlay.insert(entry);

  Future.delayed(const Duration(seconds: 3), () => entry.remove());
}
