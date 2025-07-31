import 'package:flutter/material.dart';
import 'package:tea_list/core/styles/app_colors.dart';

class TeaTypeItem extends StatelessWidget {
  TeaTypeItem({super.key, required this.title, required this.index, required this.currentIndex});

  String title;
  int index;
  int currentIndex;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    currentIndex == index ? isActive = true : isActive = false;

    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(offset: Offset(0, 1), color: AppColors.introButtonColor, spreadRadius: 0.5, blurRadius: 1),
        ],
        borderRadius: BorderRadius.circular(8),
        color: isActive ? AppColors.selectedItemColor : AppColors.introButtonColor,
      ),
      height: 50,
      width: 150,
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'Coiny',
            color: Colors.white,
            fontSize: 18,
            shadows: [
              BoxShadow(offset: Offset(0, 1), color: AppColors.introButtonColor, spreadRadius: 2, blurRadius: 3),
            ],
          ),
        ),
      ),
    );
  }
}
