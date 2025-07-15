import 'package:flutter/material.dart';

class ContainerWithImage extends StatelessWidget {
  ContainerWithImage({super.key, required this.imagePath});

  String imagePath;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Color.fromARGB(220, 0, 0, 0), blurRadius: 1, spreadRadius: 1, offset: Offset(0, 1)),
          BoxShadow(color: Color.fromARGB(220, 255, 255, 255), blurRadius: 1, spreadRadius: 1, offset: Offset(0, -1)),
        ],
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(16), child: Image.asset(imagePath, fit: BoxFit.cover)),
    );
  }
}