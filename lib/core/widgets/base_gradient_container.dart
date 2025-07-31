import 'package:flutter/material.dart';

class BaseGradientContainer extends StatelessWidget {
  BaseGradientContainer({super.key, this.height, this.colors, this.stops, this.begin, this.end});

  double? height;
  List<Color>? colors;
  List<double>? stops;
  AlignmentGeometry? begin;
  AlignmentGeometry? end;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? MediaQuery.of(context).size.height / 3.5,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin ?? Alignment.bottomCenter,
          end: end ?? Alignment.topCenter,
          colors: colors ?? [Color.fromARGB(0, 0, 0, 0), Color.fromARGB(200, 0, 0, 0), Color.fromARGB(255, 0, 0, 0)],
          stops: stops ?? [0.0, 0.02, 1.0],
        ),
      ),
    );
  }
}