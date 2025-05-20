import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/ImageQuizAppLogo/quiz-logo.png',
          width: 200,
          height: 200,
          color: const Color.fromARGB(150, 255, 255, 255),
        ),

        //Size Box To add space between widgets
        const SizedBox(height: 20),

        Text(
          'Learn Flutter the fun way!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        //Size Box To add space between widgets
        const SizedBox(height: 20),

        OutlinedButton.icon(
          style: OutlinedButton.styleFrom(
            minimumSize: Size(40, 25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, // Rectangle border
            ),
          ),
          icon: const Icon(Icons.arrow_right_alt, color: Colors.white),

          label: const Text(
            'Start A Quiz',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          onPressed: () {
            // Handle button press
          },
        ),
      ],
    );
  }
}
