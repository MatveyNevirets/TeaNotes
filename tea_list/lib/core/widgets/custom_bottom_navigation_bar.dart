import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';
import 'package:tea_list/core/widgets/custom_bottom_bar.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  CustomBottomNavigationBar({super.key, required this.currentIndex, required this.customBottomNavigationBarController});

  int currentIndex;
  PageController customBottomNavigationBarController;

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  Widget _buildNavItem(int index, IconData icon) {
    final bool isSelected = widget.currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() => widget.currentIndex = index);
        widget.customBottomNavigationBarController.animateToPage(
          index,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      },

      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.selectedItemColor : Colors.transparent,
        ),
        child: Icon(icon, color: Colors.white, size: 28),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomBar(
      children: [_buildNavItem(0, Icons.home), _buildNavItem(1, Icons.note_alt), _buildNavItem(2, Icons.favorite)],
    );
  }
}

