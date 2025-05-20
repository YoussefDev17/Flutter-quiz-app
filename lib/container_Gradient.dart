import 'package:flutter/material.dart';
import 'package:quiz_app/StartScreen.dart';

class GradientContainer extends StatelessWidget {
  final Color startColor;
  final Color endColor;
  final Alignment startAlignment;
  final Alignment endAlignment;

  const GradientContainer.purple({super.key})
    : startColor = const Color.fromARGB(255, 86, 1, 122),
      endColor = const Color.fromARGB(255, 150, 0, 195),
      startAlignment = Alignment.topCenter,
      endAlignment = Alignment.bottomCenter;

  GradientContainer(
    this.startColor,
    this.endColor,
    this.startAlignment,
    this.endAlignment, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [startColor, endColor],
          begin: startAlignment,
          end: endAlignment,
        ),
      ),
      child: Center(child: StartScreen()),
    );
  }
}
