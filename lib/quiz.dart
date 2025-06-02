import 'package:flutter/material.dart';
import 'package:quiz_app/StartScreen.dart';
import 'package:quiz_app/question_Screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState.purple();
}

class _QuizState extends State<Quiz> {
  final Color startColor;
  final Color endColor;
  final Alignment startAlignment;
  final Alignment endAlignment;

  // Track which screen to show
  Widget? activeScreen;

  _QuizState.purple()
    : startColor = const Color.fromARGB(255, 86, 1, 122),
      endColor = const Color.fromARGB(255, 150, 0, 195),
      startAlignment = Alignment.topCenter,
      endAlignment = Alignment.bottomCenter;

  @override
  void initState() {
    super.initState();
    activeScreen = StartScreen(onStartQuiz: switchScreen);
  }

  void switchScreen() {
    setState(() {
      activeScreen = QuestionScreen(
        onBackToTheStartScreen: goBackToStartScreen,
      );
    });
  }

  void goBackToStartScreen() {
    setState(() {
      activeScreen = StartScreen(onStartQuiz: switchScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [startColor, endColor],
              begin: startAlignment,
              end: endAlignment,
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
