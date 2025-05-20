import 'package:flutter/material.dart';
import 'package:quiz_app/container_Gradient.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.deepPurple,
        body: GradientContainer.purple(),
      ),
    ),
  );
}
