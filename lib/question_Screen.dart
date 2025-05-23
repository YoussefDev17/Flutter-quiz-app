import 'package:flutter/material.dart';

class QuestionScreen extends StatefulWidget {
  final VoidCallback onBackToTheStartScreen;
  const QuestionScreen({super.key, required this.onBackToTheStartScreen});
  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  _QuestionScreenState();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Question Screen',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(40, 25),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            ),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            label: const Text(
              'Back To Start Screen',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            // onPressed: () {
            //   //The Logic to go back to the start screen Will be here
            // },
            onPressed: widget.onBackToTheStartScreen, // Access from widget
          ),
        ],
      ),
    );
  }
}
